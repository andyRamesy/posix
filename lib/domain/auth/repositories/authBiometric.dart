import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthBiometricRepository{
  Future<bool> canCheckBiometrics();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<bool> authenticate();
  Future<bool> isDeviceSupported();
}