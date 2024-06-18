part of 'main_menu_bloc.dart';

@immutable
class MainMenuState {
  String goalsPath;
  String SubscriptionsPath;
  String inWorldOfGoalsPath;
  String coins;
  bool isRegister;

  MainMenuState(this.goalsPath, this.SubscriptionsPath, this.inWorldOfGoalsPath, this.coins, {this.isRegister = false});
}
