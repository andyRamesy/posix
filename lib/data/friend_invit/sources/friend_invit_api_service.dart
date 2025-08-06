import 'package:dartz/dartz.dart';
import 'package:posix/core/configs/constants/api_url.dart';
import 'package:posix/core/configs/network/dio_client.dart';
import 'package:posix/data/friend_invit/models/send_invit_request_params.dart';
import 'package:posix/service_locator.dart';

abstract class FriendInvitApiService {
  Future<Either> sendInvitation(SendInvitRequestParams receiverPhon);
}

class FriendInvitApiServiceImpl implements FriendInvitApiService {
  @override
  Future<Either> sendInvitation(SendInvitRequestParams receiverPhon) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrl.sendInvitation, data: receiverPhon);
      return Right(response);
    } catch (e) {
      return Left("Error sending invitation: $e");
    }
  }
}
