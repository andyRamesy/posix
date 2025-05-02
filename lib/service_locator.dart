import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/core/configs/network/dio_client.dart';
import 'package:posix/data/auth/repositories/auth.dart';
import 'package:posix/data/auth/repositories/auth_biometric.dart';
import 'package:posix/data/auth/sources/auth_biometric_api_service.dart';
import 'package:posix/data/auth/sources/auth_api_service.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/domain/auth/repositories/auth_biometric.dart';
import 'package:posix/domain/auth/usecases/auth_biometric.dart';
import 'package:posix/domain/auth/usecases/is_device_supported.dart';
import 'package:posix/domain/auth/usecases/is_logged_in.dart';
import 'package:posix/domain/auth/usecases/signin.dart';
import 'package:posix/domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton(() => LocalAuthentication());
  
  //services
  sl.registerSingleton<AuthBiometricService>(AuthBiometricApiServiceImpl());
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  //respositories
  sl.registerSingleton<AuthBiometricRepository>(AuthBiometricRepositoryImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //usecases
  sl.registerSingleton<IsDeviceSupportedUseCase>(IsDeviceSupportedUseCase());

  sl.registerSingleton<AuthenticateUseCase>(AuthenticateUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
}
