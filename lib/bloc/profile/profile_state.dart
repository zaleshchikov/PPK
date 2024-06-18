part of 'profile_bloc.dart';

@immutable
class ProfileState {
  String nickname;
  int id;
  bool isMe;
  bool isSubsribed;
  ProfileState(this.nickname, this.id, this.isMe, this.isSubsribed);
}


