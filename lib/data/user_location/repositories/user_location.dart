import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:posix/data/user_location/sources/user_location_services.dart';
import 'package:posix/domain/user_location/repositories/user_location.dart';
import 'package:posix/service_locator.dart';

class UserLocationRepositoryImpl extends UserLocationRepository {
  @override
  Future<Either> getUserLocation() async {
    var response = await sl<UserLocationServices>().getUserLocation();
    return response.fold(
      (error) => Left(error),
      (data) {
        Position position = data;
        return Right(position);
      },
    );
  }
}
