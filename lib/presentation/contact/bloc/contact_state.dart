part of 'contact_cubit.dart';

abstract class ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactLoaded extends ContactState {
  final List<Contact> contactList;
  ContactLoaded({required this.contactList});
}

final class ContactFailed extends ContactState {}

final class ContactSendInvitationInitial extends ContactState {}

final class ContactSendInvitationLoading extends ContactState {}

final class ContactSendInvitationSuccess extends ContactState {
  final String message;
  ContactSendInvitationSuccess({required this.message});
}

final class ContactSendInvitationFailed extends ContactState {
  final String errorMessage;
  ContactSendInvitationFailed({required this.errorMessage});
}
final class ContactEmpty extends ContactState {
  final String message;
  ContactEmpty({required this.message});
}