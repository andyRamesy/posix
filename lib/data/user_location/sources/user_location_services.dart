import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

abstract class UserLocationServices {
  Future<Either> getUserLocation();
}

class UserLocationServicesImpl extends UserLocationServices {
  @override
  Future<Either> getUserLocation() async {
    try {
      final Position position;
      final hasLocationPermission = await handlePermission();
      if (!hasLocationPermission) {
        return Future.error('Location services are disabled');
      }

      position = await Geolocator.getCurrentPosition();
      return Right(position);
    } catch (e) {
      print(e);
      return Left(e);
    }
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) return false;
    }

    if (locationPermission == LocationPermission.deniedForever) return false;
    return true;
  }
}
