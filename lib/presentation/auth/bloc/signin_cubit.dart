import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:posix/data/auth/models/signin_request_params.dart';
import 'package:posix/domain/auth/usecases/signin.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUseCase signinUseCase;
  SigninCubit({required this.signinUseCase}) : super(SigninInitial());

  Future<void> signin(SigninRequestParams params) async {
    emit(SigninLoading());
    var data = await signinUseCase.call(params);

    data.fold(
      (error) {
        final String errorMessage = error.response.data['message'];
        emit(SigninFailed(errorMessage));
      },
      (data) => emit(SigninSuccess()),
    );
  }

}
