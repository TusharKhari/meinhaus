import 'package:flutter/material.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/UserModel.dart';
import '../features/auth/screens/signin_screen.dart';
import '../provider/notifiers/auth_notifier.dart';
import '../res/common/my_snake_bar.dart';

class UserPrefrences {
  static String? _authToken;
  SharedPreferences? prefs;

// set token
  Future setToken(String authToken) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('x-auth-token', authToken);
    ("Token Saved --> $authToken").log("Utils Saved Token");
  }

// get token
  Future getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _authToken = await pref.getString('x-auth-token');
    return _authToken;
  }

// print token
  Future<void> printToken() async {
    prefs = await SharedPreferences.getInstance();
    _authToken = prefs!.getString('x-auth-token');
    print(_authToken!);
  }

// set user-id
  Future<void> setUserId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("user_id", id);
  }

// set user
  Future<void> setUser(User user, BuildContext context) async {
    context.read<AuthNotifier>().setUser(user);
  }

// get user-id
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String userId = await preferences.getString("user_id") ?? "";
    return userId;
  }

// get header
  Future<Map<String, String>> getHeader() async {
    prefs = await SharedPreferences.getInstance();
    final String token = await getToken();
    final header = {'Authorization': 'Bearer $token'};
    return header;
  }

  // Sessions
  bool isUserLoggedIn() {
    assert(prefs != null);
    final token = prefs!.getString('x-auth-token');
    return token != null;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('x-auth-token', '');
      context.pushNamedRoute(SignInScreen.routeName);
      ("User Log-out ..!!").log("UP Log-out");
    } catch (e) {
      showSnakeBar(context, e.toString());
    }
  }

  // set support status
  Future<void> setSupportStatus(int status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("support_status", status);
  }

// get support status
  Future<int> getSupportStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final int supportStatus = await preferences.getInt("support_status") ?? 0;
    return supportStatus;
  }

  // set support ticket id
  Future<void> setSupportTicketid(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("support_ticket_id", id);
  }

// get support ticket id
  Future<String> getSupportTicketId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String ticketId =
        await preferences.getString("support_ticket_id") ?? "";
    return ticketId;
  }
}
