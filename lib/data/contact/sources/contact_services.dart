import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class ContactServices {
  Future<Either> getContactList();
}

class ContactServicesImpl implements ContactServices {
  @override
  Future<Either> getContactList() async {
    bool permissionDenied = false;
    List<Contact> contacts = [];

    permissionDenied = await FlutterContacts.requestPermission();
    if (permissionDenied) {
      return throw ('Permission denied');
    }

    try {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withThumbnail: true,
        withPhoto: true,
      );
      return Right(contacts);
    } catch (e) {
      return Left(e);
    }
  }
}
