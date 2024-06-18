import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:ppk/UI/goal_screen/global_goals/global_goals_main_screen.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:ppk/bloc/add_goal_model/subGoalModel.dart';
import 'package:ppk/db/subgoals_db/subGoal_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ppk/db/user_db/user_db.dart';

import '../../request_constant/request_constant.dart';

part 'add_goal_event.dart';

part 'add_goal_state.dart';

class AddGoalBloc extends Bloc<AddGoalEvent, GlobalGoalModel> {
  AddGoalBloc()
      : super(GlobalGoalModel(
            mainPhoto: '',
            goalTags: [],
            name: '',
            text: '',
            date: DateTime.now(),
            subGoals: [],
            photos: [],
            private: true)) {
    on<AddTag>(_addTag);
    on<AddNameAndText>(_addNameAndText);
    on<AddDateGoal>(_addDate);
    on<AddSubGoals>(_addSubGoals);
    on<AddPhotos>(_addPhotos);
    on<AddPrivate>(_addPrivate);
    on<SendData>(_sendData);
    on<Update>(_update);
    on<DeleteTag>(_deleteTag);
    on<SendUpdatedData>(_sendUpdatedData);
    on<AddMainPhoto>(_addMainPhoto);
  }

  _update(Update event, Emitter<AddGoalState> emit) {
    var t = event.goal.subGoals.map((e) => e.id).toList();
    emit(GlobalGoalModel(
        goalId: event.goal.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: event.goal.goalTags,
        name: event.goal.name,
        text: event.goal.text,
        date: event.goal.date,
        subGoals: event.goal.subGoals,
        photos: event.goal.photos,
        private: event.goal.private,
        lastSubgoalsId: t.toList()));
  }

  _deleteTag(DeleteTag event, Emitter<AddGoalState> emit) {
    var tags_ = state.goalTags.toList();
    var tag = tags[int.parse(event.tag)];
    tags_.remove(tag);
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: tags_,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private));
  }

  _addTag(AddTag event, Emitter<AddGoalState> emit) {
    state.goalTags = event.tags.toList();
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: event.tags.toList(),
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private));
  }

  _addNameAndText(AddNameAndText event, Emitter<AddGoalState> emit) {
    state.name = event.name;
    state.text = event.text;
    emit(state);
  }

  _addDate(AddDateGoal event, Emitter<AddGoalState> emit) {
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: event.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private));
  }

  _addSubGoals(AddSubGoals event, Emitter<AddGoalState> emit) {
    state.subGoals = event.subGoals.toList();
    emit(state);
  }

  _addPhotos(AddPhotos event, Emitter<AddGoalState> emit) {
    state.photos = event.photos;
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private));
  }

  _addMainPhoto(AddMainPhoto event, Emitter<AddGoalState> emit) {
    state.mainPhoto = event.photo.toString();
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: event.photo.toString(),
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private));
  }

  _addPrivate(AddPrivate event, Emitter<AddGoalState> emit) {
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: event.private));
  }

  _sendUpdatedData(SendUpdatedData event, Emitter<AddGoalState> emit) async {
    var token = await DatabaseUser.getToken();

    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private,
        isLoading: true));
    var lastSubGoals = state.lastSubgoalsId.toList();
    for(var e in lastSubGoals){
      var r = await http.delete(
        Uri.parse(privatTask + e.toString()),
        headers: {
          'Authorization': "Bearer $token"
        },
      );
      var u = 0;
    }

    for(var e in state.subGoals){
      var r = await http.post(Uri.parse(privatTask),
          headers: {
            'content-type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: json.encode({
            'goal_id': state.goalId,
            "is_completed": e.isCompleted,
            "text": e.name,
            "position": state.subGoals.indexOf(e)
          }));
      var u = 0;
    }


    state.subGoals.map((e) async =>
    await http.post(Uri.parse(privatTask),
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: json.encode({
          'goal_id': state.goalId,
          "is_completed": e.isCompleted,
          "text": e.name,
          "position": state.subGoals.indexOf(e)
        })));

    var privateResponse = await http.patch(
        Uri.parse(createPrivateGoal + state.goalId.toString()),
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: json.encode({
          "text": state.text,
          "title": state.name,
          "tags": state.goalTags.map((e) => tags[e]).toList(),
          "due_date": DateFormat('yyyy-MM-dd').format(state.date),
        }));
    if (!state.private) {
      var PublicResponse = await http.post(Uri.parse(createPublicGoal),
          headers: {
            'content-type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: json.encode({
            "text": state.text,
            "title": state.name,
            "tags": state.goalTags.map((e) => tags[e]).toList(),
            "due_date": DateFormat('yyyy-MM-dd').format(state.date),
            "tasks": state.subGoals
                .map((e) => {
                      "is_completed": e.isCompleted,
                      "text": e.name,
                      "position": state.subGoals.indexOf(e)
                    })
                .toList()
          }));
    }
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private,
        isLoading: false));
    if (privateResponse.statusCode == 200) {
      emit(GlobalGoalModel(
          lastSubgoalsId: state.lastSubgoalsId,
          goalId: state.goalId,
          mainPhoto: state.mainPhoto,
          goalTags: state.goalTags,
          name: state.name,
          text: state.text,
          date: state.date,
          subGoals: state.subGoals,
          photos: state.photos,
          private: state.private,
          isSuccessRequest: true));
    } else {
      print(privateResponse.body);
    }
  }

  _sendData(SendData event, Emitter<AddGoalState> emit) async {
    var token = await DatabaseUser.getToken();
    print(token);
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private,
        isLoading: true));
    if (!state.private) {
      var r = await http.post(Uri.parse(createPublicGoal),
          headers: {
            'content-type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: json.encode({
            "text": state.text,
            "title": state.name,
            "tags": state.goalTags.map((e) => tags[e]).toList(),
            "due_date": DateFormat('yyyy-MM-dd').format(state.date),
            "tasks": state.subGoals
                .map((e) => {
                      "is_completed": e.isCompleted,
                      "text": e.name,
                      "position": state.subGoals.indexOf(e)
                    })
                .toList()
          }));
      if(r.statusCode == 200){

          var MediaResponse = await http.post(Uri.parse(publicMedia+jsonDecode(r.body)['id'].toString()),
              headers: {
                'content-type': 'multipart/form-data',
                'Authorization': "Bearer $token"
              },
              body: json.encode({
                "image":state.mainPhoto
              }));

      }
    }
    var response = await http.post(Uri.parse(createPrivateGoal),
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: json.encode({
          "text": state.text,
          "title": state.name,
          "tags": state.goalTags.map((e) => tags[e]).toList(),
          "due_date": DateFormat('yyyy-MM-dd').format(state.date),
          "tasks": state.subGoals
              .map((e) => {
                    "is_completed": e.isCompleted,
                    "text": e.name,
                    "position": state.subGoals.indexOf(e)
                  })
              .toList()
        }));
    emit(GlobalGoalModel(
        lastSubgoalsId: state.lastSubgoalsId,
        goalId: state.goalId,
        mainPhoto: state.mainPhoto,
        goalTags: state.goalTags,
        name: state.name,
        text: state.text,
        date: state.date,
        subGoals: state.subGoals,
        photos: state.photos,
        private: state.private,
        isLoading: false));
    if (response.statusCode == 200) {
      var MediaResponse = await http.post(Uri.parse(privateMedia+jsonDecode(response.body)['id'].toString()),
          headers: {
            'content-type': 'multipart/form-data',
            'Authorization': "Bearer $token"
          },
          body: json.encode({
            "image":state.mainPhoto
          }));

      emit(GlobalGoalModel(
          lastSubgoalsId: state.lastSubgoalsId,
          goalId: state.goalId,
          mainPhoto: state.mainPhoto,
          goalTags: state.goalTags,
          name: state.name,
          text: state.text,
          date: state.date,
          subGoals: state.subGoals,
          photos: state.photos,
          private: state.private,
          isSuccessRequest: true));
    } else {
      print(response.body);
    }
  }
}
