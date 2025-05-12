import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

abstract class UserLocationRepository {
  Future<Either> getUserLocation();
}
