import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/auth/repositories/auth_biometric.dart';
import 'package:posix/service_locator.dart';

class AuthenticateUseCase extends UseCase {
  @override
  Future<bool> call(params) async{
    return await sl<AuthBiometricRepository>().authenticate();
  }
}
