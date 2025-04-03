import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/domain/auth/usecases/authBiometric.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';
import 'package:posix/presentation/auth/pages/signin.dart';
import 'package:posix/presentation/auth/widgets/auth_card.dart';
import 'package:posix/service_locator.dart';

class AuthBiometricPage extends StatelessWidget {
  const AuthBiometricPage({super.key});

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

  authenticate(BuildContext context) async {
    var res = await sl<AuthenticateUseCase>().call(true);

    if (res) {
      AppNavigation.pushReplacement(context, SigninPage());
    } else {
      print("auth else : $res");
    }
  }

  Widget authBtn(BuildContext context) {
    return AuthCard(onTap: () {
      authenticate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: BlocBuilder<BiometricAuthCubit, BiometricAuthState>(
        builder: (context, state) {
          if (state is BiometricNotAvailable) {
            return Center(child: showBiometricUnavailability(context));
          } else if (state is BiometricAvailable) {
            return Center(child: authBtn(context));
          }
          return Container();
        },
      ),
    );
  }
}