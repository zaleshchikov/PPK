import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ppk/db/user_db/user_db.dart';
import 'package:sqflite/sqlite_api.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc() : super(MainMenuState('assets/my_goal_not_reg.png', 'assets/subscriptions_not_reg.png', 'assets/in_goals_world_not_reg.png', 'assets/koto_coins_not_reg.png')) {
    on<MainMenuEvent>((event, emit) async {
      if(await DatabaseUser.isRegister()){
        emit(MainMenuState('assets/my_goals.png', 'assets/subscriptions.png', 'assets/in_goals_world.png', 'assets/koto_coins.png', isRegister: true));
      }
    });
  }
}
