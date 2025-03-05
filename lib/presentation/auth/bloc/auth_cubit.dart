import 'package:bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<CheckBiometricsSupportState> {
  AuthCubit() : super(Unknown());

  void checkBiometricsSupport() async {
    final LocalAuthentication auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      if (isSupported) {
        emit(Supported());
      } else if (!isSupported) {
        emit(Unsupported());
      }
    });
  }
}
