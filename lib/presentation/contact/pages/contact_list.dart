import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/presentation/contact/bloc/contact_cubit.dart';
import 'package:posix/presentation/contact/widget/contact_tile.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit()..getContactList(),
      child: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactLoaded) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
              ),
              child: ContactTile(
                contacts: state.contactList,
              ),
            );
          } else if (state is ContactFailed) {
            return const Center(child: Text('Error loading contacts'));
          }
          return Container();
        },
      ),
    );
  }
}
