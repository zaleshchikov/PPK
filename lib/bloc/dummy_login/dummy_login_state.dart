part of 'dummy_login_bloc.dart';

@immutable
class DummyLoginState {
  bool isSuccessRequest;
  bool isLoading;
  DummyLoginState({this.isSuccessRequest = false, this.isLoading = false});
}

