part of 'contact_cubit.dart';

abstract class ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactLoaded extends ContactState {
  final List<Contact> contactList;
  ContactLoaded({required this.contactList});
}

final class ContactFailed extends ContactState {}
