import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/domain/auth/usecases/is_logged_in.dart';
import 'package:posix/presentation/splash/bloc/splash_state.dart';
import 'package:posix/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    var isLoggedIn = await sl<IsLoggedInUseCase>().call(false);
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
