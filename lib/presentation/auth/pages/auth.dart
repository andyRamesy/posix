import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/domain/auth/usecases/authenticate.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';
import 'package:posix/presentation/auth/widgets/auth_card.dart';
import 'package:posix/presentation/home/pages/home.dart';
import 'package:posix/service_locator.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

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
    final stateAuth = context.read<BiometricAuthCubit>().state;

    if (res) {
      AppNavigation.pushReplacement(context, HomePage());
    } else {
      print("auth else : $stateAuth");
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
