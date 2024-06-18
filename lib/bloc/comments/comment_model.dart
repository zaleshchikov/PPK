import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../request_constant/request_constant.dart';

class Comment{
  int id;
  String text;
  int goalId;
  int authorId;
  String authorNick;
  Comment({required this.id,required  this.text,required  this.goalId,required  this.authorId,required  this.authorNick});

  static Future<String> getNick(String authorId) async {
    var nickreap = await http.get(Uri.parse(user + '/' + authorId), headers: headers);
    var nick = '';
    if(nickreap.statusCode == 200){
      nick = json.decode(nickreap.body)['nickname'];
    }
    return nick;
  }

  static Comment fromMap(Map map, String nick) {
    return Comment(id: map['id'], text: map['text'], goalId: map['goal_id'], authorId: map['author_id'], authorNick: nick);
  }
}