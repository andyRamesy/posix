import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either> getContactList();
}
