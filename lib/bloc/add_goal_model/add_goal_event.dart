part of 'add_goal_bloc.dart';

@immutable
class AddGoalEvent {}

class Update extends AddGoalEvent{
  GlobalGoalModel goal;
  Update(this.goal);
}

class SendUpdatedData extends AddGoalEvent{
}
class AddMainPhoto extends AddGoalEvent{
  Uint8List photo;
  AddMainPhoto(this.photo);
}
class AddTag extends AddGoalEvent{
  List<String> tags;
  AddTag(this.tags);
}

class DeleteTag extends AddGoalEvent{
  String tag;
  DeleteTag(this.tag);
}

class AddNameAndText extends AddGoalEvent{
  String name;
  String text;
  AddNameAndText(this.name, this.text);
}

class AddDateGoal extends AddGoalEvent{
  DateTime date;
  AddDateGoal(this.date);
}

class AddSubGoals extends AddGoalEvent{
  List<SubGoalModel> subGoals;
  AddSubGoals(this.subGoals);
}

class AddPhotos extends AddGoalEvent{
  List<String> photos;
  AddPhotos(this.photos);
}

class AddPrivate extends AddGoalEvent{
  bool private;
  AddPrivate(this.private);
}

class SendData extends AddGoalEvent{
}
