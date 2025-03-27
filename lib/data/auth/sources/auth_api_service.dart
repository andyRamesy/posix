import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posix/core/configs/network/dio_client.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';
import 'package:posix/service_locator.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupRequestParams params);
  Future<Either> signin(SigninRequestParams params);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signin(SigninRequestParams params) async {
    try {
      var response = await sl<DioClient>().post(''); //todo: data params to send
      return Right(response);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signup(SignupRequestParams params) async {
    try {
      var response = await sl<DioClient>().post('url');
      return Right(response);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
