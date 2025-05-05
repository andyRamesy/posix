part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupFailed extends SignupState {
  final String errorMsg;
  SignupFailed(this.errorMsg);
}

class SignupSuccess extends SignupState {}
