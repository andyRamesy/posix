import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/utils/biometric_auth.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isBiometricAvailable = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    isBiometricAvailable();
  }

  Future<bool> isBiometricAvailable() async {
    bool isBiometricAvailable =
        await BiometricAuth().isDeviceSupported().then((bool value) {
      setState(() => _isBiometricAvailable = value);
      return value;
    });

    return isBiometricAvailable;
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Please authenticate to continue...",
        options: const AuthenticationOptions(stickyAuth: true),
      );
      setState(() {
        _isAuthenticated = authenticated;
      });
    } on PlatformException catch (e) {
      print("authenticate has error: $e");
      throw Exception(e);
    }
  }

  Widget showBiometricUnavailability() {
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
    return Scaffold(
      body: Center(
        child: !_isBiometricAvailable
            ? showBiometricUnavailability()
            : FutureBuilder<void>(
                future: _authenticate(),
                builder: (context, snapshot) {
                  return const CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}
