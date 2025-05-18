import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactTile extends StatelessWidget {
  final List<Contact> contacts;

  const ContactTile({
    super.key,
    required this.contacts,
  });

  imageToShow(Uint8List? image) {
    if (image != null) {
      return Image.memory(Uint8List.fromList(image));
    } else {
      return const Icon(Icons.person);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            Uint8List? imageThumbnail = contacts[index].photo ??
                contacts[index].thumbnail ??
                contacts[index].photoOrThumbnail;

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: imageToShow(imageThumbnail),
              ),
              title: Text(contacts[index].displayName),
              subtitle: Text(contacts[index].phones.isNotEmpty
                  ? contacts[index].phones.first.number
                  : 'No phone number'),
            );
          }),
    );
  }
}
