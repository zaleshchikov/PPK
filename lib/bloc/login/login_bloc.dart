import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:ppk/bloc/login/login_form.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/db/user_db/user_model.dart';
import 'package:ppk/request_constant/request_constant.dart';
import 'package:ppk/db/user_db/user_db.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(email: '', password: '', isLoading: false)) {
    on<LoginDataEvent>(_onUpdateData);
    on<SendLoginDataEvent>(_onSendData);
  }

  _onUpdateData(LoginDataEvent event, Emitter<LoginState> emit) {
    emit(LoginState(email: event.email, password: event.password, isLoading: false));
  }

  _onSendData(SendLoginDataEvent event, Emitter<LoginState> emit) async {
    if(LoginForm.form.valid){
      emit(LoginState(email: state.email, password: state.password, isLoading: true));
      var response = await http.post(
          Uri.parse(loginUrl),
          headers: headersUrlencoded,
          body: {
            "username": state.email,
            "password": state.password,
          });
      emit(LoginState(email: state.email, password: state.password, isLoading: false));
      debugPrint('email: ${state.email}');
      debugPrint('password: ${state.password}');
      debugPrint(response.statusCode.toString() + response.body);
      if(response.statusCode != 200){
        _unsuccessfulLogin(emit);
      }
      else{
        print(jsonDecode(response.body)['access_token']);
        _saveDataToDB(state.email, state.password, jsonDecode(response.body)['access_token'], state.email);
        emit(LoginState(email: '', password: '', isLoading: false, isSuccessRequest: true));
      }
    }
  }

  _saveDataToDB(String email, String password, String token, String nickName) async {
    await DatabaseUser.insert(User(email, nickName, password, token));
  }

  _unsuccessfulLogin(Emitter<LoginState> emit){
    LoginForm.form.control('email').value = '';
    LoginForm.form.control('password').value = '';
    LoginForm.form.control('email').setErrors({"Неверная почта или пароль": (error) => 'Неверная почта или пароль'});
    LoginForm.form.control('password').setErrors({"Неверная почта или пароль": (error) => 'Неверная почта или пароль'});
    emit(LoginState(email: '', password: '', isLoading: false));
  }
}
