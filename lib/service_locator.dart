import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/data/auth/repositories/authBiometric.dart';
import 'package:posix/data/auth/sources/authBiometric_api_service.dart';
import 'package:posix/domain/auth/repositories/authBiometric.dart';
import 'package:posix/domain/auth/usecases/authBiometric.dart';
import 'package:posix/domain/auth/usecases/isDeviceSupported.dart';
import 'package:posix/domain/auth/usecases/signin.dart';
import 'package:posix/presentation/auth/bloc/biometric_auth_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  //services
  sl.registerSingleton<AuthService>(AuthBiometricApiServiceImpl());
  sl.registerSingleton(() => LocalAuthentication());

  //respositories
  sl.registerSingleton<AuthBiometricRepository>(AuthBiometricRepositoryImpl());

  //usecases
  sl.registerSingleton<IsDeviceSupportedUseCase>(IsDeviceSupportedUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
}
