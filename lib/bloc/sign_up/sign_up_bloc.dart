import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../db/user_db/user_db.dart';
import '../../db/user_db/user_model.dart';
import 'sign_up_form.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/request_constant/request_constant.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState(email: '', password: '', isLoading: false)) {
    on<SignUpDataEvent>(_onUpdateData);
    on<SendSignUpDataEvent>(_onSendData);
  }

  _onUpdateData(SignUpDataEvent event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        email: event.email, password: event.password, isLoading: false));
  }

  _onSendData(SendSignUpDataEvent event, Emitter<SignUpState> emit) async {
    if (SignUpForm.form.valid) {
      emit(SignUpState(
          email: state.email, password: state.password, isLoading: true));
      var response = await http.post(Uri.parse(registerNewUserUrl),
          headers: headers,
          body: jsonEncode({
            "email": state.email,
            "password": state.password,
            "nickname": state.email
          }));
      emit(SignUpState(email: state.email, password: state.password));

      debugPrint('email: ${state.email}');
      debugPrint('password: ${state.password}');
      debugPrint(response.statusCode.toString() + response.body);

      if (response.statusCode == 201) {
        var response = await http.post(
            Uri.parse(loginUrl),
            headers: headersUrlencoded,
            body: {
              "username": state.email,
              "password": state.password,
            });
        await _saveDataToDB(state.email, state.password, jsonDecode(response.body)['access_token'], state.email);
        emit(SignUpState(
            email: state.email,
            password: state.password,
            isSuccessRequest: true));
      } else {
        SignUpForm.form
            .control('email')
            .setErrors({"Пользователь уже существует": (error) => ''});
        emit(SignUpState(email: state.email, password: state.password));
      }
    }
  }

  _saveDataToDB(String email, String password, String token, String nickName) async {
    await DatabaseUser.insert(User(email, nickName, password, token));
  }

}
