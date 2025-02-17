import 'package:dartz/dartz.dart';

abstract class AuthService {
  Future<Either> signin(params);
}

class AuthApiServiceImpl extends AuthService{
  @override
  Future<Either> signin(params) {
    // TODO: implement signin
    throw UnimplementedError();
  }
  
}