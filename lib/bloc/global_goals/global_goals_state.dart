part of 'global_goals_bloc.dart';

@immutable
class GlobalGoalsState {
  List<GlobalGoalModel> goals;
  bool isLoading;
  bool isSuccessRequest;

  GlobalGoalsState(this.goals,
      {this.isLoading = false, this.isSuccessRequest = false});
}
