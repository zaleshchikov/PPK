import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ppk/db/user_db/user_db.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/request_constant/request_constant.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState('Неизвестный\nкот', 0, false, false)) {
    on<CheckNick>(_onCheckNick);
    on<AddData>(_onAddData);
    on<AddMyData>(_onAddMyData);
    on<CheckSubscribe>(_onCheckSubscribe);
    on<Subscribe>(_onSubscribe);
  }

  _onCheckNick(CheckNick event, Emitter<ProfileState> emit) async{
    var users = await DatabaseUser.getNick();
    emit(ProfileState(users, state.id, state.isMe, state.isSubsribed));
  }

  _onAddData(AddData event, Emitter<ProfileState> emit) async{
    emit(ProfileState(event.nick, event.id, state.isMe, state.isSubsribed));
  }

  _onAddMyData(AddMyData event, Emitter<ProfileState> emit) async{
    var token = await DatabaseUser.getToken();
    var userData = await http.get(Uri.parse(user + 'me/'), headers: {
    'Authorization': "Bearer $token"
    });
    if(userData.statusCode == 200){
      emit(ProfileState(json.decode(userData.body)['nickname'], json.decode(userData.body)['id'], true, state.isSubsribed));
    }
  }

  _onSubscribe(Subscribe event, Emitter<ProfileState> emit) async{
    var token = await DatabaseUser.getToken();
    var userData = state.isSubsribed ? await http.delete(Uri.parse(follow + event.id.toString()), headers: {
      'Authorization': "Bearer $token", 'content-type': 'application/json'
    }) : await http.post(Uri.parse(follow + event.id.toString()), headers: {
      'Authorization': "Bearer $token", 'content-type': 'application/json'
    });
    if(userData.statusCode == 200){
      emit(ProfileState(json.decode(userData.body)['nickname'], json.decode(userData.body)['id'], state.isMe, !state.isSubsribed));
    }
  }

  _onCheckSubscribe(CheckSubscribe event, Emitter<ProfileState> emit) async{
    var token = await DatabaseUser.getToken();
    var userData = await http.get(Uri.parse(follow + 'is_following/${event.id}'), headers: {
      'Authorization': "Bearer $token"
    });
    if(userData.statusCode == 200){
      var data = json.decode(userData.body);
      emit(ProfileState(state.nickname, state.id, state.isMe, data['is_following']));
    }
  }


}
