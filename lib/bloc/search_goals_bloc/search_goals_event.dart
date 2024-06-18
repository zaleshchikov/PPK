part of 'search_goals_bloc.dart';

@immutable
class SearchGoalsEvent {}

class SearchGoals extends SearchGoalsEvent{
  String pattern;

  SearchGoals(this.pattern);
}
