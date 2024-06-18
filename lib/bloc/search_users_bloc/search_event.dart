part of 'search_bloc.dart';

@immutable
class SearchEvent {}

class SearchPatternEvent extends SearchEvent {
  String pattern;

  SearchPatternEvent(this.pattern);
}

