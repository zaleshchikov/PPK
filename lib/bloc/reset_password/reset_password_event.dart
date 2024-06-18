part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {

}
class ResetPasswordDataEvent extends ResetPasswordEvent{
  final String password;

  ResetPasswordDataEvent({required this.password});
}

class SendResetPasswordDataEvent extends ResetPasswordEvent{

}