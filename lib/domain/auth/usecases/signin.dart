import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';

class SigninUseCase extends UseCase<Either, SigninRequestParams>{
  @override
  Future<Either> call(SigninRequestParams params) {

    throw UnimplementedError();
  }
  
}