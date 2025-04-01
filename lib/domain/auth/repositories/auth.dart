import 'package:dartz/dartz.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';


abstract class AuthRepository{
  Future<Either> signup(SignupRequestParams params);
  Future<Either> signin(SigninRequestParams params);
}