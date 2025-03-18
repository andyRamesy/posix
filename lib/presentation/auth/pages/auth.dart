import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/utils/biometric_auth.dart';
import 'package:posix/domain/auth/usecases/authenticate.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';
import 'package:posix/service_locator.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final LocalAuthentication auth = LocalAuthentication();

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

  authenticate(BuildContext context) async {
    var res = await sl<AuthenticateUseCase>().call(true);
    if (res) {
      print("auth success $res");
    } else {
      print("auth failed $res");
    }
  }

  Widget authBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _auth();
        // authenticate(context);
      },
      child: const Text("Authenticate"),
    );
    // return Scaffold(
    //   body: ListView(
    //     children: [
    //       Column(
    //         children: [
    //           if (_supportState == _SupportState.unknown)
    //             CircularProgressIndicator()
    //           else if (_supportState == _SupportState.supported)
    //             const Text('This is supported')
    //           else if (_supportState == _SupportState.unsupported)
    //             const Text('This is not supported'),
    //           const Divider(height: 100),
    //           Text('Can check biometrics: $_canCheckBiometrics\n'),
    //           ElevatedButton(
    //             onPressed: _checkBiometrics,
    //             child: const Text('Check biometrics'),
    //           ),
    //           const Divider(height: 100),
    //           Text('Available biometrics: $_availableBiometrics\n'),
    //           ElevatedButton(
    //             onPressed: _getAvailableBiometrics,
    //             child: const Text('Get available biometrics'),
    //           ),
    //           const Divider(height: 100),
    //           Text('Current State: $_authorized\n'),
    //           if (_isAuthenticating)
    //             ElevatedButton(
    //                 onPressed: () {},
    //                 child: Row(mainAxisSize: MainAxisSize.min, children: [
    //                   Text(_isAuthenticating ? 'Cancel' : 'Authenticate'),
    //                 ]))
    //           else
    //             Column(
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: _authenticate,
    //                   child: const Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: <Widget>[
    //                       Text('Authenticate'),
    //                       Icon(Icons.perm_device_information),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }

  Future<void> _auth() async {
    bool authenticate = false;
    authenticate = await auth.authenticate(
        localizedReason: "The OS choose auth method",
        options: AuthenticationOptions(useErrorDialogs: true));
    print("value $authenticate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: authBtn(context)));
    // return BlocProvider(
    //   create: (_) {
    //     final value = sl<BiometricAuthCubit>();
    //     value.isDeviceSupported();
    //     return value;
    //   },
    //   child: Scaffold(
    //     body: Center(child: authBtn(context)),
    //   ),
    // );
  }
}
