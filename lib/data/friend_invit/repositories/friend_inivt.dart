import 'package:dartz/dartz.dart';
import 'package:posix/data/friend_invit/models/send_invit_request_params.dart';
import 'package:posix/data/friend_invit/sources/friend_invit_api_service.dart';
import 'package:posix/domain/friend_invit/repositories/friend_invit.dart';
import 'package:posix/service_locator.dart';

class FriendInivtRepositoryImpl extends FriendInvitRepository {
  @override
  Future<Either> sendInvitation(SendInvitRequestParams receiverPhon) async {
    var data = await sl<FriendInvitApiService>().sendInvitation(receiverPhon);
    return data.fold((error) {
      return Left(error);
    }, (data) async {
      return Right(data);
    });
  }
}
