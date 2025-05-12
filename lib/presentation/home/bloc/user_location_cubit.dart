import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:posix/domain/user_location/usecases/retrieve_user_location.dart';
import 'package:posix/service_locator.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit() : super(UserLocationInitial());

  void getUserLocation() async {
    emit(UserLocationLoading());
    var userPosition = await sl<RetrieveUserLocationUseCase>().call(false);
    userPosition.fold(
      (error) => emit(UserLocationOnFailure()),
      (data) => emit(UserLocationOnSuccess(userLocation: data)),
    );
  }
}
