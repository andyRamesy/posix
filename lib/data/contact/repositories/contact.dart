import 'package:dartz/dartz.dart';
import 'package:posix/data/contact/sources/contact_services.dart';
import 'package:posix/domain/contact/repositories/contact.dart';
import 'package:posix/service_locator.dart';

class ContactRepositoryImpl extends ContactRepository {
  @override
  Future<Either> getContactList() async {
    var response = await sl<ContactServices>().getContactList();
    return response.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }
}
