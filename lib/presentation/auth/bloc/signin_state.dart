part of 'signin_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}
final class SigninLoading extends SigninState {}
final class SigninSuccess extends SigninState {}
final class SigninFailed extends SigninState {
  final String errorMsg;
  SigninFailed(this.errorMsg);
}
