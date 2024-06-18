import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/calendar_add_goal.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/notebook.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/subgoal.dart';
import 'package:ppk/UI/goal_screen/today_goals/calendar.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';
import '../../../../bloc/calendar_bloc/calendar_bloc.dart';
import '../../../../bloc/today_goals/today_golas_bloc.dart';

class AddDate extends StatelessWidget {
  AddDate({super.key});

  static monthNumberToName(int number) {
    switch (number) {
      case 1:
        return 'Января';
      case 2:
        return 'Февраля';
      case 3:
        return 'Марта';
      case 4:
        return 'Апреля';
      case 5:
        return 'Мая';
      case 6:
        return 'Июня';
      case 7:
        return 'Июля';
      case 8:
        return 'Августа';
      case 9:
        return 'Сентебря';
      case 10:
        return 'Октября';
      case 11:
        return 'Ноября';
      case 12:
        return 'Декабря';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.hoverColor,
          appBar: AppBar(
              backgroundColor: theme.hoverColor,
              leading: Container(
                padding: EdgeInsets.only(left: size.width / 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: size.width * 0.08,
                    height: size.width * 0.08,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/close_notebook.png'))),
                  ),
                ),
              )),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                      textAlign: TextAlign.center,
                      'Подберите дату',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: theme.textTheme.titleLarge!.color)),
                ),
                Container(height: size.height / 20),
                CalendarAddGoal(),
                Container(height: size.height/10),
                Container(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<AddGoalBloc>(context)
                          .add(AddDateGoal(BlocProvider.of<CalendarBloc>(context).state.today));
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (contexmt, animation,
                            secondaryAnimation) {
                          // Navigate to the SecondScreen
                          return BlocProvider.value(
                            value: BlocProvider.of<AddGoalBloc>(context),
                            child: SubGoals(),
                          );
                        },
                        transitionsBuilder: (context, animation,
                            secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation =
                          animation.drive(tween);
                          return SlideTransition(
                            // Apply slide transition
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ));
                    },
                    child: Center(
                        child: Container(
                          width: size.width / 2.1,
                          height: size.width / 4,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,
                                      3), // changes position of shadow
                                ),
                              ],
                              color: theme.hintColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              'Сохранить',
                              style: theme.textTheme.titleMedium!
                                  .copyWith(
                                  color: theme
                                      .textTheme.titleLarge!.color),
                            ),
                          ),
                        )),
                  ),
                )

              ],
            ),
          ),
        );
      }),
    );
  }
}
