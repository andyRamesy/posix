import 'package:local_auth/local_auth.dart';
import 'package:posix/data/auth/sources/auth_api_service.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {

  @override
  Future<bool> authenticate() async{
    var res = await sl<AuthService>().authenticate();
    return res;
  }

  @override
  Future<bool> canCheckBiometrics() {
    var res = sl<AuthService>().canCheckBiometrics();
    return res;
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() {
    var res = sl<AuthService>().getAvailableBiometrics();
    return res;
  }
  
}
