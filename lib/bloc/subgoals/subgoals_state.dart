part of 'subgoals_bloc.dart';

@immutable
class SubGoalsState {
  String mainGoal;
  String textFieldValue;
  List<SubGoalModel> taskList;
  bool lastIsNew;
  int indexOfChangeingTask;
  SubGoalsState(this.mainGoal,this.taskList, {this.textFieldValue = '', this.lastIsNew = false, this.indexOfChangeingTask = -1});
}
