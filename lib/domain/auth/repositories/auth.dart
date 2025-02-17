import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either> signin(params);
  Future<bool> isLoggedIn();

}