import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/auth/repositories/authBiometric.dart';
import 'package:posix/service_locator.dart';

class IsDeviceSupportedUseCase extends UseCase<bool,dynamic> {
  @override
  Future<bool> call(params) async{
    return await sl<AuthBiometricRepository>().isDeviceSupported();
  }
  
}