import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/domain/auth/usecases/authenticate.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';
import 'package:posix/presentation/auth/widgets/auth_card.dart';
import 'package:posix/service_locator.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthState();
}

class _AuthState extends State<AuthPage> {
  Widget showBiometricUnavailability(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fingerprint, size: 32, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(
            'Biometric Unavailable',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  // Future<void> _auth() async {
  //   bool authenticate = await auth.authenticate(
  //     localizedReason: "The OS choose auth method",
  //     options: const AuthenticationOptions(useErrorDialogs: true),
  //   );
  //   print("value $authenticate");
  // }

  // Widget authBtn(BuildContext context) {
  //   return AuthCard(
  //     child: ElevatedButton(
  //       onPressed: () => _auth(),
  //       child: const Text("Authenticate"),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BiometricAuthCubit, BiometricAuthState>(
          listener: (context, state) {
            if(state is BiometricNotAvailable){
              print("not");
            }else {
              print("ok");
            }
          },child: Center(child: Text("ok"),)),
    );
  }
}
