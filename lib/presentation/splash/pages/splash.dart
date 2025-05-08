import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/presentation/auth/bloc/signin_cubit.dart';
import 'package:posix/presentation/auth/pages/signin.dart';
import 'package:posix/presentation/home/pages/home.dart';
import 'package:posix/presentation/splash/bloc/splash_cubit.dart';
import 'package:posix/presentation/splash/bloc/splash_state.dart';
import 'package:posix/service_locator.dart';

import '../../../core/configs/assets/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            AppNavigation.pushReplacement(context,BlocProvider(
              create: (context) => sl<SigninCubit>(),
              child: SigninPage(),
              
            ));
          } else if (state is Authenticated) {
            AppNavigation.pushReplacement(context, HomePage());
          }
        },
        child: Stack(
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
      ),
    );
  }
}
