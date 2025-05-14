import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/service_locator.dart';

class LogoutUseCase extends UseCase {
  @override
  call(params) async {
    return await sl<AuthRepository>().logout();
  }
}
