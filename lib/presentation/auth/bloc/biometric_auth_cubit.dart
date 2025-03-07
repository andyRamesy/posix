import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/domain/auth/usecases/isDeviceSupported.dart';
import 'package:posix/service_locator.dart';

part 'biometric_auth_state.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  BiometricAuthCubit() : super(BiometricInitial());

  Future<void> isDeviceSupported() async{
    bool response = await sl<IsDeviceSupportedUseCase>().call(false);
    if(false){
      emit(BiometricAvailable());
    }else{
      emit(BiometricNotAvailable());
    }
  }
}
  