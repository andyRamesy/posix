import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:posix/data/contact/sources/contact_services.dart';
import 'package:posix/domain/contact/repositories/contact.dart';
import 'package:posix/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactRepositoryImpl extends ContactRepository {
  @override
  Future<Either> getContactList({int offset = 0, int limit = 10}) async {
    var response = await sl<ContactServices>()
        .getContactList(offset: offset, limit: limit);

    return response.fold(
      (error) => Left(error),
      (data) async {
        return Right(data);
      },
    );
  }
}
