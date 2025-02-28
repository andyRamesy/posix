import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/service_locator.dart';

class AuthenticateUseCase extends UseCase {
  @override
  Future call(params) {
    return sl<AuthRepository>().authenticate();
  }
}
