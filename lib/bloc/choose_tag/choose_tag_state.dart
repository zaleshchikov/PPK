part of 'choose_tag_bloc.dart';

@immutable
 class ChooseTagState {
  List<String> tags;
  Color buttonColor;
  ChooseTagState(this.tags ,{this.buttonColor = Colors.grey});
}

