part of 'global_goals_bloc.dart';

@immutable
class GlobalGoalsEvent {}

class updateData extends GlobalGoalsEvent{

}

class updateDataPercent extends GlobalGoalsEvent{
  int percent;
  bool isMe;
  int id;
  updateDataPercent(this.percent, this.isMe, this.id);
}
