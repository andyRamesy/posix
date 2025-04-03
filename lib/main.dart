import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';
import 'package:posix/presentation/splash/pages/splash.dart';
import 'package:posix/service_locator.dart';

import 'core/configs/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BiometricAuthCubit()..isDeviceSupported(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          theme: AppTheme.appTheme,
        ));
  }
}

