import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/data/friend_invit/models/send_invit_request_params.dart';
import 'package:posix/domain/friend_invit/repositories/friend_invit.dart';
import 'package:posix/service_locator.dart';

class SendInvitUseCase extends UseCase<Either, SendInvitRequestParams> {
  @override
  Future<Either> call(params) async {
    return await sl<FriendInvitRepository>().sendInvitation(params);
  }
}
