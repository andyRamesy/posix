import 'package:flutter_bloc/flutter_bloc.dart';

part 'biometric_auth_state.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  BiometricAuthCubit() : super(BiometricInitial());
}
