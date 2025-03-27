import 'package:dartz/dartz.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';
import 'package:posix/data/auth/sources/auth_api_service.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninRequestParams params) async {
    var data = await sl<AuthApiService>().signin(params);
    return data.fold((error) {
      return Left(error);
    }, (data) async {
      //todo sharedPref
      return Right(data);
    });
  }

  @override
  Future<Either> signup(SignupRequestParams params) async {
    // TODO: implement signup
    var data = await sl<AuthApiService>().signup(params);
    return data.fold((error) {
      return Left(error);
    }, (data) {
      //todo shared pref
      return Right(data);
    });
  }
}
