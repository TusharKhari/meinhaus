import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:new_user_side/pusher_test.dart';
import 'package:new_user_side/res/routing/router.dart';
import 'package:new_user_side/static%20componets/splash/screens/intro_screen.dart';
import 'package:provider/provider.dart';

import 'provider/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_dMedZ8RG75Z6EwiJlqr1ZY3O";
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
    return ScreenUtilInit(
      designSize: const Size(393, 781),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Mein Haus',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          home: const IntroScreen(),
          onGenerateRoute: (settings) => generateRoute(settings),
        );
      },
    );
  }
}
