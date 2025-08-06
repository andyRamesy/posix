import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:posix/core/configs/network/dio_client.dart';
import 'package:posix/data/auth/repositories/auth.dart';
import 'package:posix/data/auth/repositories/auth_biometric.dart';
import 'package:posix/data/auth/sources/auth_biometric_api_service.dart';
import 'package:posix/data/auth/sources/auth_api_service.dart';
import 'package:posix/data/contact/repositories/contact.dart';
import 'package:posix/data/contact/sources/contact_services.dart';
import 'package:posix/data/friend_invit/repositories/friend_inivt.dart';
import 'package:posix/data/friend_invit/sources/friend_invit_api_service.dart';
import 'package:posix/data/user_location/repositories/user_location.dart';
import 'package:posix/data/user_location/sources/user_location_services.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/domain/auth/repositories/auth_biometric.dart';
import 'package:posix/domain/auth/usecases/auth_biometric.dart';
import 'package:posix/domain/auth/usecases/is_device_supported.dart';
import 'package:posix/domain/auth/usecases/is_logged_in.dart';
import 'package:posix/domain/auth/usecases/logout.dart';
import 'package:posix/domain/auth/usecases/signin.dart';
import 'package:posix/domain/auth/usecases/signup.dart';
import 'package:posix/domain/contact/repositories/contact.dart';
import 'package:posix/domain/contact/usecases/contact_list.dart';
import 'package:posix/domain/friend_invit/repositories/friend_invit.dart';
import 'package:posix/domain/friend_invit/usecases/send_invit.dart';
import 'package:posix/domain/user_location/repositories/user_location.dart';
import 'package:posix/domain/user_location/usecases/retrieve_user_location.dart';
import 'package:posix/presentation/auth/bloc/signin_cubit.dart';
import 'package:posix/presentation/auth/bloc/signup_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton(() => LocalAuthentication());

  //services
  sl.registerSingleton<AuthBiometricService>(AuthBiometricApiServiceImpl());
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<UserLocationServices>(UserLocationServicesImpl());
  sl.registerSingleton<ContactServices>(ContactServicesImpl());
  sl.registerSingleton<FriendInvitApiService>(FriendInvitApiServiceImpl());

  //respositories
  sl.registerSingleton<AuthBiometricRepository>(AuthBiometricRepositoryImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserLocationRepository>(UserLocationRepositoryImpl());
  sl.registerSingleton<ContactRepository>(ContactRepositoryImpl());
  sl.registerSingleton<FriendInvitRepository>(FriendInivtRepositoryImpl());

  //Auth biometric usecases
  sl.registerSingleton<IsDeviceSupportedUseCase>(IsDeviceSupportedUseCase());
  sl.registerSingleton<AuthenticateUseCase>(AuthenticateUseCase());

  //Simple Auth usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  //Contact usecase
  sl.registerSingleton<GetContactListUseCase>(GetContactListUseCase());

  //cubits Auth
  sl.registerFactory<SignupCubit>(
      () => SignupCubit(signupUseCase: SignupUseCase()));
  sl.registerFactory<SigninCubit>(
      () => SigninCubit(signinUseCase: SigninUseCase()));

  //User location usecase
  sl.registerSingleton<RetrieveUserLocationUseCase>(
      RetrieveUserLocationUseCase());

  //Friend invit usecase
  sl.registerSingleton(SendInvitUseCase());
}
