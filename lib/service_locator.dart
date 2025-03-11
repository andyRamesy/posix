import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/data/auth/repositories/auth.dart';
import 'package:posix/data/auth/sources/auth_api_service.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/domain/auth/usecases/authenticate.dart';
import 'package:posix/domain/auth/usecases/isDeviceSupported.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  //services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());
  sl.registerLazySingleton(() => LocalAuthentication());

  //respositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //usecases
  sl.registerSingleton<IsDeviceSupportedUseCase>(IsDeviceSupportedUseCase());
  sl.registerFactory<AuthenticateUseCase>(() => AuthenticateUseCase());
}
