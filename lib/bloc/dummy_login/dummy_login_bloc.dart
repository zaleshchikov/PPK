import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/request_constant/request_constant.dart';
import 'package:ppk/db/user_db/user_db.dart';
import 'package:ppk/db/user_db/user_model.dart';

part 'dummy_login_event.dart';
part 'dummy_login_state.dart';

class DummyLoginBloc extends Bloc<DummyLoginEvent, DummyLoginState> {
  DummyLoginBloc() : super(DummyLoginState()) {
    on<Login>(_onLogin);
  }

  _onLogin(DummyLoginEvent event, Emitter<DummyLoginState>emit) async {
    emit(DummyLoginState(isLoading: true));
    var registerUser = await http.post(
        Uri.parse(dummyUser));
    if(registerUser.statusCode == 201){
      var email = jsonDecode(registerUser.body)['email'];
      var password = jsonDecode(registerUser.body)['nickname'].substring(5);
      var password2 = jsonDecode(registerUser.body)['nickname'];
      var singUpResponse = await http.post(
          Uri.parse(loginUrl),
          headers: headersUrlencoded,
          body: {
            "username": email,
            "password": password,
          });
      if(singUpResponse.statusCode == 200){
        await _saveDataToDB(jsonDecode(registerUser.body)['email'], jsonDecode(registerUser.body)['nickname'].substring(6), jsonDecode(singUpResponse.body)['access_token'], 'Неизвестный\nкот');
        emit(DummyLoginState(isLoading: false, isSuccessRequest: true));
      } else{
        emit(DummyLoginState());
      }
    } else{
      emit(DummyLoginState());
    }
  }
  _saveDataToDB(String email, String password, String token, String nickName) async {
    await DatabaseUser.insert(User(email, nickName, password, token));
  }

}
