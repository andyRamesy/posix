import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_invit_state.dart';

class SendInvitCubit extends Cubit<SendInvitState> {
  SendInvitCubit() : super(SendInvitInitial());
}
