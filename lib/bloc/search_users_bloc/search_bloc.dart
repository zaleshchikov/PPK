import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:ppk/UI/profile/profile_model.dart';
import 'package:ppk/request_constant/request_constant.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState([])) {
    on<SearchPatternEvent>(_onSearch);
  }

  _onSearch(SearchPatternEvent event, Emitter<SearchState> emit) async {
    var searchResult = await http.get(Uri.parse(findUser + event.pattern), headers: headers);
    if (searchResult.statusCode == 200) {
      var decodedSearchResult = json.decode(utf8.decode(searchResult.bodyBytes));
      var result = <ProfileModel>[
        ...decodedSearchResult.map((e) =>
            ProfileModel(e['nickname'], '', e['id'])).toList()
      ];
      emit(SearchState(result));
    }
  }

}
