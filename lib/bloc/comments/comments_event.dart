part of 'comments_bloc.dart';

@immutable
 class CommentsEvent {}

class GetComments extends CommentsEvent{
  int id;

  GetComments(this.id);
}

class WriteComment extends CommentsEvent{
  String comment;
  int goalIf;

  WriteComment(this.comment, this.goalIf);
}
