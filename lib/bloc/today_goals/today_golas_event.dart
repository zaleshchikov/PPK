part of 'today_golas_bloc.dart';

@immutable
class TodayGoalsEvent{}


class TodayGoalsGetDateEvent extends TodayGoalsEvent{
  DateTime day;
  TodayGoalsGetDateEvent(this.day);
}

class TodayGoalsGetDateAndStatusEvent extends TodayGoalsEvent{
  DateTime day;
  bool status;
  TodayGoalsGetDateAndStatusEvent(this.day, this.status);
}

class TodayGoalsOpenTextFieldEvent extends TodayGoalsEvent{
}

class TodayGoalsCloseTextFieldEvent extends TodayGoalsEvent{
}

class TodayGoalsChangeDoneStatusEvent extends TodayGoalsEvent{
  int index;
  TodayGoalsChangeDoneStatusEvent(this.index);
}

class TodayGoalsChangeTaskEvent extends TodayGoalsEvent{
  int changingIndex;
  TodayGoalsChangeTaskEvent(this.changingIndex);
}

class TodayGoalsChangeNameTaskEvent extends TodayGoalsEvent{
  int changingIndex;
  TodayGoalsChangeNameTaskEvent(this.changingIndex);
}



