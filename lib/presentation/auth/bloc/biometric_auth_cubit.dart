import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/domain/auth/usecases/authBiometric.dart';
import 'package:posix/domain/auth/usecases/isDeviceSupported.dart';
import 'package:posix/service_locator.dart';
part 'biometric_auth_state.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  BiometricAuthCubit() : super(BiometricInitial());

  void isDeviceSupported() async {
    bool response = await sl<IsDeviceSupportedUseCase>().call(false);
    if (response) {
      emit(BiometricAvailable());
    } else {
      emit(BiometricNotAvailable());
    }
  }

  void authenticate() async {
    bool response = await sl<AuthenticateUseCase>().call(false);
    if (response) {
      print("response bloc: $response");
      emit(BiometricSuccess());
    } else {
      emit(BiometricFailure("Authentication failed"));
    }
  }
}
