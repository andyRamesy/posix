import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/data/friend_invit/models/send_invit_request_params.dart';
import 'package:posix/presentation/contact/bloc/contact_cubit.dart';

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
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Send invitation"),
                actions: [
                  BlocConsumer<ContactCubit, ContactState>(
                    listener: (context, state) {
                      if (state is ContactSendInvitationSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Invitation sent to ${contacts.displayName}",
                          ),
                        ));
                      } else if (state is ContactSendInvitationFailed) {
                        print("state on error: ${state.errorMessage}");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)));
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () async {
                          print(
                              "Sending invitation to ${contacts.phones.first.number}");
                          final params = SendInvitRequestParams(
                              receiverPhon: contacts.phones.first.number);
                          await context
                              .read<ContactCubit>()
                              .sendInvitation(params);
                          // Handle success or failure of sending invitation
                        },
                        child: const Text("Send"),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
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
