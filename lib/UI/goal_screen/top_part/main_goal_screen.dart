import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/global_goals_main_screen.dart';
import 'package:ppk/UI/goal_screen/today_goals/main_today_goals_screen.dart';
import 'package:ppk/UI/goal_screen/train/begin_train.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/calendar_bloc/calendar_bloc.dart';
import '../../../bloc/today_goals/today_golas_bloc.dart';
import 'top_statistic.dart';
import '../global_goals/categories.dart';

class MainGoalScreen extends StatelessWidget {
  const MainGoalScreen({super.key});

  Future isTrain() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return [prefs.getBool('isNotMainGoalTrain') ?? true, prefs];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    WidgetsBinding.instance
        .addPostFrameCallback(
            (_) async {
          var snapshot = await isTrain();
          if (snapshot[0]) {
            snapshot[1].setBool('isNotMainGoalTrain', false);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    BeginTrain(
                        1, 9, 'тутор', BottomNavigationScreen(MainGoalScreen()),
                        2),
                transitionDuration: Duration(milliseconds: 400),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
          }
        }
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
        BlocProvider(
          create: (context) =>
          TodayGoalsBloc()
            ..add(TodayGoalsGetDateEvent(DateTime.now())),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          body: SingleChildScrollView(
            child: Container(
              height: size.height * 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopStatistic(),
                  Container(height: size.height / 20),
                  BlocBuilder<TodayGoalsBloc, TodayGoalsState>(
                    builder: (context, state) {
                      return Container(
                          height: size.height * 2.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/today_goals_back.png'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(70)),
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  child: SizedBox(
                                      height: size.height * 2,
                                      width: size.width,
                                      child: MainTodayGoalsScreen())),
                              Positioned(
                                  bottom: 0,
                                  height: size.height * 1.05,
                                  width: size.width,
                                  child: SizedBox(child: GlobalGoals()))
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
