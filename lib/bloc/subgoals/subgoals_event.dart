part of 'subgoals_bloc.dart';

@immutable
class SubGoals{}


class SubGoalsGetDate extends SubGoals{
  String mainGoal;
  SubGoalsGetDate(this.mainGoal);
}

class SubGoalsOpenTextField extends SubGoals{
}

class SubGoalsCloseTextField extends SubGoals{
}

class SubGoalsAddExistingGoals extends SubGoals{
  List<SubGoalModel> subgoals;
  SubGoalsAddExistingGoals(this.subgoals);
}

class SubGoalsChangeDoneStatus extends SubGoals{
  int index;
  SubGoalsChangeDoneStatus(this.index);
}

class SubGoalsChangeTask extends SubGoals{
  int changingIndex;
  SubGoalsChangeTask(this.changingIndex);
}

class SubGoalsChangeNameTask extends SubGoals{
  int changingIndex;
  SubGoalsChangeNameTask(this.changingIndex);
}




