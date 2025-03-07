import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/utils/biometric_auth.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';
import 'package:posix/service_locator.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

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
            'Biometric Unavailability',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BiometricAuthCubit>()..isDeviceSupported(),
      child: Scaffold(
        body: BlocBuilder<BiometricAuthCubit, BiometricAuthState>(
          builder: (context, state) {
            if (state is BiometricNotAvailable) {
              return Center(child: showBiometricUnavailability(context));
            } else {
              return const Text("Hello");
            }
          },
        ),
      ),
    );
  }
}
