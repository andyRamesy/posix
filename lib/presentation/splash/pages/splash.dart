import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/presentation/splash/bloc/splash_cubit.dart';
import 'package:posix/presentation/splash/bloc/splash_state.dart';

import '../../../core/configs/assets/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Center(child: Text('You have to authenticate'));
          } else if (state is Authenticated) {
            Center(child: Text('Authenticated'));
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.splashImage))),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff1A1B20).withOpacity(0),
                    const Color(0xff1A1B20)
                  ])),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff1A1B20).withOpacity(0),
                      const Color(0xff1A1B20),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
