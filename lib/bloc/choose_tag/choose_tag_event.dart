part of 'choose_tag_bloc.dart';

@immutable
class ChooseTagEvent {}

class selectTag extends ChooseTagEvent{
  String tag;
  selectTag(this.tag);
}

class addTags extends ChooseTagEvent{
  List<String> tags;
  addTags(this.tags);
}
