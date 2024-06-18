part of 'profile_bloc.dart';

@immutable
class ProfileEvent {}

class CheckNick extends ProfileEvent{

}

class AddData extends ProfileEvent{
  int id;
  String nick;

  AddData(this.id, this.nick);
}

class AddMyData extends ProfileEvent{

}

class CheckSubscribe extends ProfileEvent{
  int id;

  CheckSubscribe(this.id);

}

class Subscribe extends ProfileEvent{
  int id;

  Subscribe(this.id);
}