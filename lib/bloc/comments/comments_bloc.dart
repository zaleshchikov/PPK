import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:ppk/request_constant/request_constant.dart';
import '../../db/user_db/user_db.dart';
import '../add_goal_model/global_goal_model.dart';
import 'comment_model.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsState([])) {
    on<WriteComment>(_onWriteComments);
    on<GetComments>(_onGetComments);
  }

  _onGetComments(GetComments event, Emitter<CommentsState> emit) async {
    var token = await DatabaseUser.getToken();
    http.Response response = await http.get(Uri.parse(createPublicGoal + event.id.toString()), headers: {
      'Authorization': "Bearer $token"
    });
    List<Comment> comments = [];
    if(response.statusCode == 200){
      for(var e in json.decode(utf8.decode(response.bodyBytes))['comments']){
        var nick = await Comment.getNick(e['author_id'].toString());
        comments.add(Comment.fromMap(e, nick));
      }
    }
    emit(CommentsState(comments));
  }

  _onWriteComments(WriteComment event, Emitter<CommentsState> emit) async {
    var token = await DatabaseUser.getToken();
    http.Response response = await http.post(Uri.parse(comments), headers: {
      'Authorization': "Bearer $token",
      'content-type': 'application/json'
    },
    body: json.encode({
      "text" : event.comment.toString(),
      "goal_id": event.goalIf.toString()
    }));
    print(response.body);
    emit(CommentsState(state.comments.toList()));
  }
}
