import 'package:dartz/dartz.dart';
import 'package:posix/domain/auth/repositories/auth.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(params) {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async{
    return true;
  }



}