part of 'sign_up_bloc.dart';

@immutable
class SignUpEvent {

}

class SignUpDataEvent extends SignUpEvent{
  final String email;
  final String password;

  SignUpDataEvent({required this.email, required this.password});
}

class SendSignUpDataEvent extends SignUpEvent{

}
