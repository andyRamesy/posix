import 'package:dartz/dartz.dart';
import 'package:posix/data/friend_invit/models/send_invit_request_params.dart';

abstract class FriendInvitRepository {
  Future<Either> sendInvitation(SendInvitRequestParams receiverPhon);
}
