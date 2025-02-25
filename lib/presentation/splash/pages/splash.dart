import 'package:flutter/material.dart';
import 'package:posix/presentation/splash/pages/splash_controller.dart';

import '../../../core/configs/assets/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController splashController;

  @override
  void initState() {
    super.initState();
    splashController = SplashController(context);
    splashController.startTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.splashImage))),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color(0xFFFF9900).withOpacity(0),
              const Color(0xFFFF9900)
            ])),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xffffffff).withOpacity(0),
                    const Color(0xFFFF9900),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
