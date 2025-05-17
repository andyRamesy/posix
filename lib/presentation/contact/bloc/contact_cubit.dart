import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:posix/domain/contact/usecases/contact_list.dart';
import 'package:posix/service_locator.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  void getContactList() async{
    emit(ContactLoading());
    var contactList = await sl<GetContactListUseCase>().call(false);
    contactList.fold((error) => emit(ContactFailed()), (data) => emit(ContactLoaded(contactList: data)));
  }
}
