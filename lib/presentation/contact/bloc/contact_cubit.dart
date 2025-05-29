import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:posix/domain/contact/usecases/contact_list.dart';
import 'package:posix/service_locator.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  List<Contact> contactList = [];
  bool isFetching = false;
  int _offset = 0;
  int _limit = 20;
  bool hasMore = true;

  ContactCubit() : super(ContactInitial());

  void getContactList() async {
    emit(ContactLoading());
    _offset = 0;
    contactList.clear();
    final result = await sl<GetContactListUseCase>().call({'offset': _offset, 'limit': _limit});

    result.fold(
      (error) => emit(ContactFailed()),
      (data) {
        if(data.isEmpty) {
          emit(ContactEmpty(message: 'Your contact list is empty'));
          return;
        }
        isFetching = false;
        contactList.addAll(data);
        hasMore = data.length == _limit;
        emit(ContactLoaded(contactList: contactList));
      },
    );
  }

  void fetchMoreContacts() async {
    if (isFetching || !hasMore) return;
    isFetching = true;
    _offset += _limit;

    final result = await sl<GetContactListUseCase>().call({'offset': _offset, 'limit': _limit});

    result.fold(
      (error) {
        isFetching = false;
        emit(ContactFailed());
      },
      (data) {
        contactList.addAll(data);
        hasMore = data.length == _limit;
        emit(ContactLoaded(contactList: contactList));
        isFetching = false;
      },
    );
  }
}
