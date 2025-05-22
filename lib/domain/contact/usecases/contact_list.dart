import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/contact/repositories/contact.dart';
import 'package:posix/service_locator.dart';

class GetContactListUseCase extends UseCase<Either, Map<String, int>> {
  @override
  Future<Either> call(Map<String, int> params) async {
    return await sl<ContactRepository>().getContactList(
      offset: params['offset']!,
      limit: params['limit']!,
    );
  }
}
//
