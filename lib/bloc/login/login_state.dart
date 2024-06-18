part of 'login_bloc.dart';

@immutable
class LoginState {

  final String email;
  final String password;
  final bool isLoading;
  bool isSuccessRequest;

  LoginState({required this.email, required this.password, required this.isLoading, this.isSuccessRequest = false});

}


