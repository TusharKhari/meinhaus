import 'package:flutter/material.dart';
import 'package:new_user_side/res/common/my_text.dart';

class ShowError extends StatelessWidget {
  final String error;
  const ShowError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    late final errorScreen;
    if (error.contains("subtype")) {
      errorScreen = Scaffold(
        body: Center(
          child: MyTextPoppines(text: "Json Error"),
        ),
      );
    } else if (error.contains("400")) {
      errorScreen = Scaffold(
        body: Center(
          child: MyTextPoppines(text: "404 Error"),
        ),
      );
    } else if (error.contains("404")) {
      errorScreen = Scaffold(
        body: Center(
          child: MyTextPoppines(text: "404 Error"),
        ),
      );
    } else if (error.contains("500")) {
      errorScreen = Scaffold(
        body: Center(
          child: MyTextPoppines(text: "500 Error"),
        ),
      );
    } else {
      errorScreen = Scaffold(
        body: Center(
          child: MyTextPoppines(text: "Something went worng"),
        ),
      );
    }

    return errorScreen;
  }
}
