import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/request_constant/request_constant.dart';
import '../../db/user_db/user_db.dart';
import '../add_goal_model/global_goal_model.dart';

part 'news_world_event.dart';
part 'news_world_state.dart';

class NewsWorldBloc extends Bloc<NewsWorldEvent, NewsWorldState> {
  NewsWorldBloc() : super(NewsWorldState([])) {
    on<UpdateGoals>(_onUpdateGoals);
  }

  _onUpdateGoals(UpdateGoals event, Emitter<NewsWorldState> emit) async {
    var token = await DatabaseUser.getToken();
    var goalsResp = await http.get(Uri.parse(follow + 'feed/'), headers: JsonContentHeaders(token));
    if(goalsResp.statusCode == 200){
      var res = json.decode(goalsResp.body);
      var goals = <GlobalGoalModel>[...json.decode(goalsResp.body).map((e) => GlobalGoalModel.fromMap(e)).toList()];
      goals = goals.where((element) => element.goalTags.isNotEmpty).toList();
      emit(NewsWorldState(goals));
    }
  }
}
