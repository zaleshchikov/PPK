import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:ppk/bloc/reset_password/reset_password_form.dart';
import 'package:http/http.dart' as http;
import '../../request_constant/request_constant.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc()
      : super(ResetPasswordState(password: '', isLoading: false)) {
    on<ResetPasswordDataEvent>(_onUpdateData);
    on<SendResetPasswordDataEvent>(_onSendData);
  }

  _onUpdateData(
      ResetPasswordDataEvent event, Emitter<ResetPasswordState> emit) {
    emit(ResetPasswordState(password: event.password, isLoading: false));
  }

  _onSendData(SendResetPasswordDataEvent event,
      Emitter<ResetPasswordState> emit) async {
    if (ResetPasswordForm.form.valid) {
      emit(ResetPasswordState(password: state.password, isLoading: true));
      var response = await http.post(Uri.parse(registerNewUserUrl),
          headers: headers, body: jsonEncode({}));
      emit(ResetPasswordState(password: state.password, isLoading: false));
      debugPrint('password: ${state.password}');
      debugPrint(response.statusCode.toString() + response.body);
    }
  }
}
