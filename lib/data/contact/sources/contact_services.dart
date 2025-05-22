import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContactServices {
  Future<Either> getContactList({int offset, int limit});
}

class ContactServicesImpl implements ContactServices {
  @override
  Future<Either> getContactList({int offset = 0, int limit = 20}) async {
    List<Contact> contacts = [];
    final permissionDenied = await FlutterContacts.requestPermission();
    if (permissionDenied) return throw ('Permission denied');

    try {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withThumbnail: true,
        withPhoto: true,
      );
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('contacts', contacts.toString());
      
      final paginated = contacts.skip(offset).take(limit).toList();
      return Right(paginated);
    } catch (e) {
      return Left(e);
    }
  }
}
