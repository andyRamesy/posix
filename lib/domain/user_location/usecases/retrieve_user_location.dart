import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:posix/core/usecase/usecase.dart';
import 'package:posix/domain/user_location/repositories/user_location.dart';
import 'package:posix/service_locator.dart';

class RetrieveUserLocationUseCase extends UseCase<Either, dynamic>{
  @override
  Future<Either> call(params) async {
    return await sl<UserLocationRepository>().getUserLocation();
  }
  
}