import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:new_user_side/features/splash/screens/intro_screen.dart';
import 'package:new_user_side/firebase_options.dart';
import 'package:new_user_side/resources/routing/router.dart';
 import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
 import 'provider/provider.dart';

///  prod test env is in constants 
/// otp validation just go in auth_notifier "signUp" function

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await PushNotificationServices().initNotifications();
  Stripe.publishableKey = dotenv.env['stripePublishableKey']!;
  runApp(
    MultiProvider(
      providers: provider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      // designSize: const Size(393, 781),
      designSize: Size(width, height),
      builder: (context, child) {
        return 
            MaterialApp(
          title: 'Mein Haus',
          debugShowCheckedModeBanner: isTest,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          navigatorKey: navigatorKey,
          home: IntroScreen(),
          onGenerateRoute: (settings) => generateRoute(settings),
        );
      },
    );
  }
}
