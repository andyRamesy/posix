import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthBiometricService {
  Future<bool> authenticate();
  Future<bool> canCheckBiometrics();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<bool> isDeviceSupported();
}

class AuthBiometricApiServiceImpl extends AuthBiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    try {
      var res = await auth.authenticate(
          localizedReason: "The OS choose auth method",
          options: AuthenticationOptions(
            useErrorDialogs: true,
            biometricOnly: true,
          ));

      print("source : $res");
      return res;
    } on PlatformException catch (e) {
      print("error on authenticate : $e");
      throw Exception(e);
    }
  }

  @override
  Future<bool> canCheckBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print("error on canCheckBiometrics : $e");
      return false;
    }
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } on PlatformException catch (error) {
      print("on getAvailableBiometrics : $error");
      return [];
    }
  }

  @override
  Future<bool> isDeviceSupported() async {
    return await auth.isDeviceSupported();
  }
}
