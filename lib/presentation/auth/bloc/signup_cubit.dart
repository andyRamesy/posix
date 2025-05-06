import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/service_locator.dart';
import 'package:posix/domain/auth/usecases/signup.dart';
import 'package:posix/data/auth/models/signup_request_params.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit({required this.signupUseCase}) : super(SignupInitial());

  Future<void> signup(SignupRequestParams params) async {
    emit(SignupLoading());
    var data = await sl<SignupUseCase>().call(params);

    data.fold(
      (error) {
        final String errorMessage = error[0];
        emit(SignupFailed(errorMessage));
      },
      (data) => emit(SignupSuccess()),
    );
  }
}
