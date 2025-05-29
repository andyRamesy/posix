import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';
import 'package:posix/domain/auth/repositories/auth.dart';
import 'package:posix/service_locator.dart';

class SigninUseCase extends UseCase<Either, SigninRequestParams> {

  @override
  Future<Either> call(SigninRequestParams params) async {
    return await sl<AuthRepository>().signin(params);
  }
  
}