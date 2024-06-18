import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/request_constant/request_constant.dart';

import '../../db/user_db/user_db.dart';
import 'dart:convert' show utf8;

part 'global_goals_event.dart';
part 'global_goals_state.dart';

class GlobalGoalsBloc extends Bloc<GlobalGoalsEvent, GlobalGoalsState> {
  GlobalGoalsBloc() : super(GlobalGoalsState([], isLoading: true)) {
    on<updateData>(_onUpdateData);
    on<updateDataPercent>(_onUpdateDataPercent);
  }

  _onUpdateData(updateData event, Emitter<GlobalGoalsState> emit) async {
    var token = await DatabaseUser.getToken();
    http.Response response = await http.get(Uri.parse(createPrivateGoal), headers: {
    'Authorization': "Bearer $token"
    });
    emit(GlobalGoalsState([], isLoading: false));
    if(response.statusCode == 200){
      List<GlobalGoalModel> goals = <GlobalGoalModel>[...json.decode(utf8.decode(response.bodyBytes)).map((e) => GlobalGoalModel.fromMap(e)).toList()];
      emit(GlobalGoalsState(goals, isSuccessRequest: true));
    }
  }

  _onUpdateDataPercent(updateDataPercent event, Emitter<GlobalGoalsState> emit) async {
    var token = await DatabaseUser.getToken();
    http.Response response = await http.get(Uri.parse(event.isMe ? myGoals : createPublicGoal + event.id.toString()), headers: {
      'Authorization': "Bearer $token"
    });
    emit(GlobalGoalsState([], isLoading: false));
    if(response.statusCode == 200){
      List<GlobalGoalModel> goals = <GlobalGoalModel>[...json.decode(utf8.decode(response.bodyBytes)).map((e) => GlobalGoalModel.fromMap(e)).toList()];
      goals = event.percent == 0 ?
      goals.where((element) => element.subGoals.isEmpty ? true : (((element.subGoals.where((e) => e.isCompleted)).length / element.subGoals.length)) == 0).toList() :
      event.percent == 1 ? goals.where((element) => element.subGoals.isEmpty ? false : (((element.subGoals.where((e) => e.isCompleted)).length / element.subGoals.length)) < 1 && (((element.subGoals.where((e) => e.isCompleted)).length / element.subGoals.length)) != 0).toList()
      : goals.where((element) => element.subGoals.isEmpty ? false : (((element.subGoals.where((e) => e.isCompleted)).length / element.subGoals.length)) == 1.00).toList();
      emit(GlobalGoalsState(goals, isSuccessRequest: true));
    }
  }

}
