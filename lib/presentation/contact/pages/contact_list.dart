import 'dart:typed_data';

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
  final ContactCubit _contactCubit = ContactCubit();
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _contactCubit.getContactList();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _contactCubit.fetchMoreContacts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageToShow(Uint8List? image) {
      if (image != null) {
        return Image.memory(Uint8List.fromList(image));
      }
      return const Icon(Icons.person);
    }

    return BlocProvider.value(
      value: _contactCubit,
      child: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactLoaded) {
            return ListView.builder(
                controller: _scrollController,
                itemCount:
                    state.contactList.length + (_contactCubit.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.contactList.length) {
                    return ContactTile(contacts: state.contactList[index]);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else if (state is ContactFailed) {
            return const Center(child: Text('Error loading contacts'));
          }
          return Container();
        },
      ),
    );
  }
}
