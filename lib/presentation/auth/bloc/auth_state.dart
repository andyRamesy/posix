part of 'auth_cubit.dart';

abstract class CheckBiometricsSupportState{}

class Supported extends CheckBiometricsSupportState{}
class Unsupported extends CheckBiometricsSupportState{}
class Unknown extends CheckBiometricsSupportState{}
