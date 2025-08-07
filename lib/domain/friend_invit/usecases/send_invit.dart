import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/data/friend_invit/models/send_invit_request_params.dart';

class SendInvitUseCase extends UseCase<Either, SendInvitRequestParams> {
  @override
  Future<Either> call(params) async {
    return Right("Invitation sent to $params");
  }
}
