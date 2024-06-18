import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/calendar_add_goal.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/main_photo.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/subgoals.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/change_goal_note.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/tags.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:ppk/bloc/global_goals/global_goals_bloc.dart';
import 'package:ppk/bloc/subgoals/subgoals_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';
import '../../../../bloc/calendar_bloc/calendar_bloc.dart';
import '../../../../request_constant/request_constant.dart';
import '../add_goal/add_date.dart';
import '../add_goal/choose_tag.dart';

class ChangeGoalMainScreen extends StatelessWidget {
  const ChangeGoalMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocListener<AddGoalBloc, GlobalGoalModel>(
      listener: (context, state) {
        if (state.isSuccessRequest) {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return BottomNavigationScreen(MainGoalScreen());
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                // Apply slide transition
                position: offsetAnimation,
                child: child,
              );
            },
          ));
        }
      },
      child: BlocBuilder<AddGoalBloc, GlobalGoalModel>(
        builder: (context, state) {
          print(state.goalTags);
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SubGoalsBloc(),
              ),
            ],
            child: Builder(builder: (context) {
              return Container(
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height * 2.5 + size.height / 4,
                    width: size.width,
                    child: Scaffold(
                      resizeToAvoidBottomInset: true,
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
                                        image: AssetImage(
                                            'assets/close_notebook.png'),
                                        fit: BoxFit.fitWidth)),
                              ),
                            ),
                          )),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: size.height / 8,
                              width: size.width,
                              child: Center(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'Это ваша цель',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme
                                                .textTheme.titleLarge!.color)),
                              ),
                            ),
                            Container(
                              height: size.height * 2.5,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/change_back_2.png'),
                                      fit: BoxFit.fitWidth)),
                              child: Container(
                                padding: EdgeInsets.only(left: size.width / 5),
                                child: Column(
                                  children: [
                                    Container(height: size.height / 18),
                                    Row(
                                      children: [
                                        Text(
                                            'Выполнить до ${state.date.day} ${monthNumberToName(state.date.month)}',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(
                                                    color: theme.hoverColor)),
                                      ],
                                    ),
                                    Container(height: size.height / 30),
                                    Container(
                                        height: size.height / 2.3,
                                        child: ChangeGoalNote()),
                                    Row(
                                      children: [
                                        Text(
                                            textAlign: TextAlign.center,
                                            'Теги',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme.textTheme
                                                        .titleLarge!.color)),
                                      ],
                                    ),
                                    Container(height: size.height / 100),
                                    TagsList(),
                                    Container(height: size.height / 100),
                                    Row(
                                      children: [
                                        Text(
                                            textAlign: TextAlign.center,
                                            'Дата',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme.textTheme
                                                        .titleLarge!.color)),
                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: size.width / 10),
                                        child: BlocBuilder<CalendarBloc,
                                            CalendarState>(
                                          builder: (context, state) {
                                            return CalendarAddGoal();
                                          },
                                        )),
                                    Container(height: size.height / 100),
                                    Row(
                                      children: [
                                        Text(
                                            textAlign: TextAlign.center,
                                            'Шаги',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme.textTheme
                                                        .titleLarge!.color)),
                                      ],
                                    ),
                                    SubGoalsList.IsShirt(),
                                    Row(
                                      children: [
                                        Text(
                                            textAlign: TextAlign.center,
                                            'Фотография',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme.textTheme
                                                        .titleLarge!.color)),
                                      ],
                                    ),
                                    Container(height: size.height / 100),
                                    MainPhoto(
                                      state.mainPhoto,
                                      bytesList: null,
                                    ),
                                    Container(height: size.height / 50),
                                    Row(
                                      children: [
                                        Text(
                                            textAlign: TextAlign.center,
                                            'Режим',
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme.textTheme
                                                        .titleLarge!.color)),
                                      ],
                                    ),
                                    Container(height: size.height / 100),
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: size.width / 20),
                                      child: Row(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            elevation: 4,
                                            child: Container(
                                              height: size.width / 3,
                                              width: size.width / 3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/privat.png',
                                                      ),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<AddGoalBloc>(
                                                      context)
                                                  .add(AddPrivate(
                                                      !state.private));
                                            },
                                            child: ImageFilter(
                                                hue: 0.0,
                                                brightness:
                                                    !state.private ? 0.0 : -0.3,
                                                saturation: 0.0,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                  ),
                                                  elevation: 4,
                                                  child: Container(
                                                    height: size.width / 3,
                                                    width: size.width / 3,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'assets/public.png',
                                                            ),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(height: size.height / 30),
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: size.width / 10),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<AddGoalBloc>(
                                                    context)
                                                .add(AddSubGoals(BlocProvider
                                                        .of<SubGoalsBloc>(
                                                            context)
                                                    .state
                                                    .taskList));
                                            BlocProvider.of<AddGoalBloc>(
                                                    context)
                                                .add(AddDateGoal(BlocProvider
                                                        .of<CalendarBloc>(
                                                            context)
                                                    .state
                                                    .today));
                                            if (state.goalId == -1) {
                                              BlocProvider.of<AddGoalBloc>(
                                                      context)
                                                  .add(SendData());
                                            } else {
                                              BlocProvider.of<AddGoalBloc>(
                                                      context)
                                                  .add(SendUpdatedData());
                                            }
                                          },
                                          child: Container(
                                            width: size.width / 2.1,
                                            height: size.width / 4,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                color: Color(0xffF7D78D),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                              child: state.isLoading
                                                  ? Center(
                                                      child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: theme
                                                                .backgroundColor,
                                                          )))
                                                  : Text(
                                                      'Сохранить',
                                                      style: theme.textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color: theme
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .color),
                                                    ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
