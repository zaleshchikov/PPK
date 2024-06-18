import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/bloc/add_goal_model/subGoalModel.dart';
import 'package:ppk/db/subgoals_db/subGoal_model.dart';
import 'package:ppk/request_constant/request_constant.dart';

class GlobalGoalModel implements AddGoalState {
  List<String> goalTags;
  String name;
  String text;
  DateTime date;
  List<SubGoalModel> subGoals;
  String mainPhoto;
  List<String> photos;
  bool private;
  bool isLoading;
  bool isSuccessRequest;
  int goalId;
  List lastSubgoalsId;

  GlobalGoalModel(
      {required this.goalTags,
      required this.name,
      required this.text,
      required this.date,
      required this.subGoals,
      required this.photos,
      required this.private,
      this.isLoading = false,
      this.isSuccessRequest = false,
      this.goalId = 0,required this.mainPhoto, this.lastSubgoalsId = const []});

  static GlobalGoalModel fromMap(Map map) {
    return GlobalGoalModel(
      mainPhoto: '',
      goalId: map['id'],
        goalTags: <String>[...map['tags'].map((e) => tags[e['id']]).toList()],
        name: map['title'],
        text: map['text'] ?? '',
        date: map['due_date'] == null ? DateTime.now() : DateTime.parse(map['due_date']),
        subGoals:
        <SubGoalModel>[...map['tasks'].
        map<SubGoalModel>((e) =>
            SubGoalModel.fromServerMap(e))
            .toList()],
        photos: [],
        private: true);
  }

  Copy() =>{
    GlobalGoalModel(goalTags: goalTags, name: name, text: text, date: date, subGoals: subGoals, photos: photos, private: private, mainPhoto: mainPhoto, isLoading: isLoading, isSuccessRequest: isSuccessRequest, goalId: goalId, lastSubgoalsId: lastSubgoalsId)
  };

}
