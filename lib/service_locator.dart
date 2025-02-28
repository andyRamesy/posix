import 'package:get_it/get_it.dart';
import 'package:posix/data/auth/repositories/auth.dart';
import 'package:posix/data/auth/sources/auth_api_service.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/domain/auth/usecases/authenticate.dart';
import 'package:posix/domain/auth/usecases/checkAuthenticateBiometrics.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  //services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());

  //respositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //usecasers
  sl.registerSingleton<CheckauthenticateBiometricsUseCase>(
      CheckauthenticateBiometricsUseCase());
  sl.registerSingleton<AuthenticateUseCase>(AuthenticateUseCase());
}
