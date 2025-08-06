import 'package:dartz/dartz.dart';
import 'package:posix/core/usecase/usecase.dart';

class SendInvitUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call(params) async {
    return Right("Invitation sent to $params");
  }
}
