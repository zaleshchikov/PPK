part of 'today_golas_bloc.dart';

@immutable
class TodayGoalsState {
  DateTime day;
  String textFieldValue;
  List<DailyTask> taskList;
  bool lastIsNew;
  int indexOfChangeingTask;
  TodayGoalsState(this.day,this.taskList, {this.textFieldValue = '', this.lastIsNew = false, this.indexOfChangeingTask = -1});
}

