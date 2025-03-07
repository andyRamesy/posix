part of 'biometric_auth_cubit.dart';

abstract class BiometricAuthState {}

class BiometricInitial extends BiometricAuthState {}

class BiometricLoading extends BiometricAuthState {}

class BiometricAvailable extends BiometricAuthState {}

class BiometricNotAvailable extends BiometricAuthState {}

class BiometricSuccess extends BiometricAuthState {}

class BiometricFailure extends BiometricAuthState {
  final String message;
  BiometricFailure(this.message);
}
