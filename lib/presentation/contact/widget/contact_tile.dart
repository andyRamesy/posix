import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:posix/core/configs/theme/app_color.dart';

class ContactTile extends StatelessWidget {
  final Contact contacts;

  const ContactTile({
    super.key,
    required this.contacts,
  });

  Widget imageToShow(Uint8List? image) {
    if (image != null) {
      return ClipOval(
        child: Image.memory(
          image,
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
      );
    } else {
      return const Icon(Icons.person, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageThumbnail =
        contacts.photo ?? contacts.thumbnail ?? contacts.photoOrThumbnail;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.customWhite,
          child: imageToShow(imageThumbnail),
        ),
        title: Text(contacts.displayName),
        subtitle: Text(
          contacts.phones.isNotEmpty
              ? contacts.phones.first.number
              : 'No phone number',
        ),
      ),
    );
  }
}
