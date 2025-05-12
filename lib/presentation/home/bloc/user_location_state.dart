part of 'user_location_cubit.dart';

abstract class UserLocationState {}

class UserLocationInitial extends UserLocationState {}

class UserLocationLoading extends UserLocationState {}

class UserLocationOnFailure extends UserLocationState {}

class UserLocationOnSuccess extends UserLocationState {
  final Position userLocation;
  UserLocationOnSuccess({required this.userLocation});
}
