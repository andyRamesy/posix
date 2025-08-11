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
      print("friend invite api service error $e");
      return Left("Error in api service sending invitation: $e");
    }
  }
}
