import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/data/models/UserModel.dart';
import 'package:new_user_side/features/auth/screens/add_phone_number_screen.dart';
import 'package:new_user_side/features/auth/screens/create_new_password_screen.dart';
import 'package:new_user_side/features/auth/screens/create_starting_project_screen.dart';
import 'package:new_user_side/features/auth/screens/forget_password_otp_verifation_screen.dart';
import 'package:new_user_side/features/auth/screens/signin_screen.dart';
import 'package:new_user_side/features/edit%20profile/screens/edit_profile_screen.dart';
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/repository/auth_repository.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/network/network_api_servcies.dart';
import '../../features/auth/screens/otp_validate_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../resources/common/my_snake_bar.dart';

class AuthNotifier extends ChangeNotifier {
  AuthRepositorys repository = AuthRepositorys();
  final prefs = UserPrefrences();

  // variabless
  bool _isToggle = false;
  bool _isWaiting = false;
  bool _loading = false;
  bool _loading2 = false;
  bool _gloading = false;
  User _user = User();
  bool _isAuthenticated = false;
  String accessToken = "";
  String deviceName = "";
  bool _isUserFirstVisit = true;
  bool _aLoading = false;
  // getters
  bool get isToggle => _isToggle;
  bool get isWaiting => _isWaiting;
  User get user => _user;
  bool get loading => _loading;
  bool get loading2 => _loading2;
  bool get gLoading => _gloading;
  bool get isAuthenticated => _isAuthenticated;
  bool get isUserFirstVisit => _isUserFirstVisit;
  bool get aLoading => _aLoading;

  // setters
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setLoading2State(bool state, bool notify) {
    _loading2 = state;
    if (notify) notifyListeners();
  }

  void setGoogleLoadingState(bool state, bool notify) {
    _gloading = state;
    if (notify) notifyListeners();
  }

  void setAppleLoadingState(bool state, bool notify) {
    _aLoading = state;
    if (notify) notifyListeners();
  }

  void setToggle(bool val) {
    _isToggle = val;
    notifyListeners();
  }

  void setWaiting(bool val) {
    _isWaiting = val;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUser() {
    _user;
    notifyListeners();
  }

  void setAuthentication(bool isAuth) {
    _isAuthenticated = isAuth;
    notifyListeners();
  }

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    } else {
      return "Flutter || Dart";
    }
  }

  void onErrorHandler(
    BuildContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    showSnakeBarr(context, "$error", SnackBarState.Error);
    if (isTest) ("$error $stackTrace").log("Auth notifier");
    //Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

// Auth
  Future authentication(BuildContext context) async {
    final pref = await UserPrefrences();
    // final pref = await UserPrefrences();
    //_isUserFirstVisit =  prefs.getIsUserFirstVisit();
    // prefs.setIsUserFirstVisit(isFirstVisit: false);
    await repository.auth().then((response) {
      if (isTest) ("Token Verified!🔥").log("uth_Notifier");
      final user = UserModel.fromJson(response).user!;
      setUser(user);
      pref.setUserId(user.userId.toString());
      //Navigator.pushNamed(context, HomeScreen.routeName);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }).onError((error, stackTrace) {
      // ("$error $stackTrace").log("Auth notifier");
    });
  }

  // set sanctum
  Future sanctum() async {
    final response = await http.get(
      Uri.parse("$baseUrl2/sanctum/csrf-cookie"),
      // Uri.parse("https://meinhaus.ca/sanctum/csrf-cookie"),
    );
    final xsrf = response.headers['set-cookie'];
    await UserPrefrences().setXsrf(xsrf.toString());
  }

// Login
  Future login(MapSS data, BuildContext context) async {
    setLoadingState(true, true);
    // await sanctum().then((value) {
    repository.login(data).then((response) async {
      if (response['response_code'] == "401") {
        showSnakeBarr(
          context,
          "Invalid Email or Password",
          SnackBarState.Error,
        );
        setLoadingState(false, true);
      } else {
        User user = UserModel.fromJson(response).user!;
        setUser(user);
        await prefs.setToken(user.token!);
        if (user.phoneVerified!) {
          if (isTest) ("User Logged in Successfully ✨").log("Login Notifier");
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        } else {
          showSnakeBarr(
            context,
            "Please verify you details first",
            SnackBarState.Warning,
          );
          Navigator.of(context).pushScreen(
            OtpValidateScreen(
              userId: user.userId!,
              contactNo: user.contact!,
              isSkippAble: false,
            ),
          );
        }
        setLoadingState(false, true);
      }
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
    // }).onError((error, stackTrace) {
    //   ("$error $stackTrace").log("Xsrf Auth notifier");
    // });
  }

// SignUp
  Future signUp(MapSS data, BuildContext context) async {
    setLoadingState(true, true);
    repository.signUp(data).then((response) async {
      setLoadingState(false, true);
      if (isTest) (response).log("SignUp Response");
      if (isTest) (data).log("sign up data");
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);

      // ==== when otp validation is required just uncomment this  ====
      // Navigator.of(context).pushScreen(
      //   OtpValidateScreen(
      //     userId: response["user_id"],
      //     contactNo: data["phone"]!,
      //     isSkippAble: true,
      //   ),
      // );
      // ============

      /// otp validation is not required here when user sign up all details will be registered and just login with those details
      /// ==== comment this line when otp validation is required  ====
      await login(data, context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CreateStartingProject(),
          ));
      // ======
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

// Verify Phone
  Future verifyPhone({
    required MapSS body,
    required BuildContext context,
    bool isFromSetting = false,
  }) async {
    setLoadingState(true, true);
    repository.verifyPhone(body).then((response) async {
      setLoadingState(false, true);
      final user = UserModel.fromJson(response).user!;
      UserPrefrences().setToken(user.token.toString());
      setUser(user);
      isFromSetting
          ? Navigator.pop(context)
          : Navigator.of(context).pushScreen(CreateStartingProject());
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Verify Email
  Future verifyEmail(BuildContext context) async {
    setLoadingState(true, true);
    await repository.verifyEmai().then((response) async {
      setLoadingState(false, true);
      showSnakeBarr(context, "Verification link sent", SnackBarState.Success);
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Send OTP On Mobile Number
  Future sendOTPOnMobile({
    required MapSS body,
    required BuildContext context,
  }) async {
    setLoadingState(true, true);
    await repository.sendOTPMobile(body).then((response) async {
      setLoadingState(false, true);
      showSnakeBarr(context, "OTP Sent", SnackBarState.Success);
      showDialog(
        context: context,
        builder: (context) {
          return VerifyPhoneNoDialog();
        },
      );
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Resend OTP For Verification
  Future resendOtp({
    required MapSS body,
    required BuildContext context,
  }) async {
    await repository.resendOtp(body).then((response) {
      showSnakeBarr(
        context,
        response['response_message'],
        SnackBarState.Success,
      );
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
    });
  }

  // Add phone-number if user don't have any
  Future<void> addPhoneNo({
    required MapSS body,
    required BuildContext context,
  }) async {
    setLoadingState(true, true);
    await repository.addPhoneNo(body).then((response) {
      showSnakeBarr(
          context, "Let's verify your phone number", SnackBarState.Info);
      Navigator.of(context).pushScreen(
        OtpValidateScreen(
          userId: int.parse(body['user_id']!),
          contactNo: body['phone']!,
          isSkippAble: true,
        ),
      );
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Google Authentication
  Future googleAuth(BuildContext context) async {
    setGoogleLoadingState(true, true);
    try {
      // Creating an user with google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      // accessToken =  gUser.id;
      accessToken = await gAuth.accessToken!;
      print("gToken ${accessToken}");

      if (accessToken.isNotEmpty) googleSignIn(context);
    } catch (e) {
      showSnakeBarr(
        context,
        "Something went wrong try again",
        SnackBarState.Warning,
      );
      // print("gauth $e");
      setGoogleLoadingState(false, true);
    }
  }

  // Google Authentication Login/Signup
  Future googleSignIn(BuildContext context) async {
    MapSS data = {"provider": "google", "access_token": accessToken};
    if (isTest) print(data);
    await repository.googleLogin(data).then((response) async {
      print(response);
      // showSnakeBarr(
      //   context,
      //   response['response_message'],
      //   SnackBarState.Success,
      // );
      User user = UserModel.fromJson(response).user!;
      setUser(user);
      await prefs.setToken(user.token!);
      setGoogleLoadingState(false, true);
      if (user.contact == null || user.phoneVerified == false) {
        Navigator.of(context).pushScreen(
          AddPhoneNumberScreen(userId: user.userId.toString()),
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      }
    }).onError((error, stackTrace) {
      setGoogleLoadingState(false, true);

      onErrorHandler(context, error, stackTrace);
    });
  }

// apple sign in

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> appleSignIn({required BuildContext context}) async {
    setAppleLoadingState(true, true);
    String rawNonce = generateNonce();
    String nonce = sha256ofString(rawNonce);
    await firebaseAuth.FirebaseAuth.instance.signOut();
    await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    ).then((credential) async {
      final oauthCredential =
          firebaseAuth.OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        rawNonce: rawNonce,
      );
      await firebaseAuth.FirebaseAuth.instance
          .signInWithCredential(oauthCredential);

      firebaseAuth.User? firebaseUser =
          firebaseAuth.FirebaseAuth.instance.currentUser;

      // =====================
      MapSS data = {
        "provider": "apple",
        "access_token": firebaseUser?.uid ?? credential.authorizationCode,
        // "access_token": credential.authorizationCode,
        "email": firebaseUser?.email ?? "",
        "name": firebaseUser?.displayName ?? credential.givenName ?? "N/A",
        // "name": firebaseUser?.displayName ?? "N/A",
        // "name": credential.givenName ?? "N/A",
      };
      if (isTest) print(data);
      await repository.appleSignIn(data).then((response) async {
        User user = UserModel.fromJson(response).user!;
        setUser(user);
        await prefs.setToken(user.token!);
        setAppleLoadingState(false, true);
        if (user.contact == null || user.phoneVerified == false) {
          Navigator.of(context).pushScreen(
            AddPhoneNumberScreen(userId: user.userId.toString()),
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        }
      }).onError((error, stackTrace) {
        setAppleLoadingState(false, true);
        onErrorHandler(context, "Something went wrong.", stackTrace);
      });
      // =========
    }).onError((error, stackTrace) {
      setAppleLoadingState(false, true);
      onErrorHandler(context, "Something went wrong.", stackTrace);
    });
  }

  // Forget password will send and otp to given email
  Future<void> forgetPassword({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repository.forgetPassword(body).then((value) {
      showSnakeBarr(context, "OTP SENT", SnackBarState.Success);
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(
        ForgetPasswordOtpValidateScreen(email: body['email']!),
      );
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Verify forget password otp
  Future<void> verifyForgetPassOTP({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repository.verifyForgetPassOTP(body).then((response) {
      showSnakeBarr(context, "OTP Verified", SnackBarState.Success);
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(
        CreateNewPasswordScreen(passwordToken: response['token']),
      );
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Resend forget password otp
  Future<void> resendForgetPassOTP({
    required BuildContext context,
    required MapSS body,
  }) async {
    setGoogleLoadingState(true, true);
    await repository.resendFOrgetPassOTP(body).then((response) {
      showSnakeBarr(context, "OTP Sent Again!", SnackBarState.Success);
      setGoogleLoadingState(false, true);
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setGoogleLoadingState(false, true);
    });
  }

  // Create new password
  Future<void> createNewPasswordViaFP({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repository.createNewPasswordViaFP(body).then((response) {
      showSnakeBarr(
        context,
        "New Password has been created login with same credentials!",
        SnackBarState.Success,
      );
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(SignInScreen());
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  // Log-out
  Future logout(BuildContext context) async {
    try {
      if (user.isSocialLogin != null) {
        if (isTest) ("Social").log("Log-out");
        final GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
        UserPrefrences().logOut(context);
        //  await firebaseAuth.FirebaseAuth.instance.signOut();
        //  print('Signed out successfully.');
      } else {
        //  print("Social login is null");
        if (isTest) ("normal").log("Log-out");
        UserPrefrences().logOut(context);
      }
    } catch (error) {
      ("$error").log("Logout notifier");
    }
  }

  // delete account

  Future deleteAccount(BuildContext context) async {
    setLoadingState(true, true);
    await repository.deleteAccount().then((value) {
      if (isTest) print("delete account $value");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
          (route) => false);
      logout(context);
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      print("delete account error $error");
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }
}
