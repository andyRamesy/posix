import 'package:local_auth/local_auth.dart';
import 'package:posix/data/auth/sources/auth_biometric_api_service.dart';
import 'package:posix/domain/auth/repositories/auth_biometric.dart';
import 'package:posix/service_locator.dart';

class AuthBiometricRepositoryImpl extends AuthBiometricRepository {

  

  @override
  Future<bool> authenticate() async{
    var res = await sl<AuthBiometricService>().authenticate();
    return res;
  }

  @override
  Future<bool> canCheckBiometrics() {
    var res = sl<AuthBiometricService>().canCheckBiometrics();
    return res;
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() {
    var res = sl<AuthBiometricService>().getAvailableBiometrics();
    return res;
  }
  
  @override
  Future<bool> isDeviceSupported() async{
    var res = await sl<AuthBiometricService>().isDeviceSupported();
    return res;
  }
  
}
