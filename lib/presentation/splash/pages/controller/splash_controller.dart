import 'package:flutter/material.dart';
import 'package:posix/presentation/auth/pages/auth.dart';

class SplashController {
  final BuildContext context;
  SplashController(this.context);

  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if(context.mounted){
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthPage(),
        ));
      }
    });
  }
}