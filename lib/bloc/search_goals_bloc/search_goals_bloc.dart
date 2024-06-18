import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../request_constant/request_constant.dart';
import '../add_goal_model/global_goal_model.dart';

part 'search_goals_event.dart';
part 'search_goals_state.dart';

class SearchGoalsBloc extends Bloc<SearchGoalsEvent, SearchGoalsState> {
  SearchGoalsBloc() : super(SearchGoalsState([])) {
    on<SearchGoals>(_onSearch);
  }

  _onSearch(SearchGoals event, Emitter<SearchGoalsState> emit) async {
    var searchResult = await http.get(Uri.parse(createPublicGoal + '?page_number=0&page_size=10&title=${event.pattern}'), headers: headers);
    if (searchResult.statusCode == 200) {
      var decodedSearchResult = json.decode(utf8.decode(searchResult.bodyBytes));
      var result = <GlobalGoalModel>[
        ...decodedSearchResult.map((e) =>
            GlobalGoalModel.fromMap(e)).toList()
      ];
      emit(SearchGoalsState(result));
    }
  }
}
