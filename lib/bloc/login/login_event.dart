part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {

}

class LoginDataEvent extends LoginEvent{
  final String email;
  final String password;

  LoginDataEvent({required this.email, required this.password});
}

class SendLoginDataEvent extends LoginEvent{

}
