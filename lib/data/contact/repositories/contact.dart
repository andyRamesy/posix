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
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('contactList');
    if (cached != null && offset == 0) {
      final decoded = jsonDecode(cached);
      final paginated = decoded.skip(offset).take(limit).toList();
      return Right(paginated);
    }
    var response = await sl<ContactServices>()
        .getContactList(offset: offset, limit: limit);

    return response.fold(
      (error) => Left(error),
      (data) async {
        if (offset == 0) {
          final jsonData = jsonEncode(data);
          await prefs.setString("contactList", jsonEncode(jsonData));
        }
        return Right(data);
      },
    );
  }
}
