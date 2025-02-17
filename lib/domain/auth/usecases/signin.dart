import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/auth/repositories/auth.dart';

import '../../../service_locator.dart';

class SigninUseCase extends UseCase<Either, dynamic>{
  @override
  Future<Either> call(params) async{
    return await sl<AuthRepository>().signin(params);
  }

}