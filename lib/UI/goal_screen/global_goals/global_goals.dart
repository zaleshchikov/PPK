import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/global_goal_screen/global_goal_main_screen.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/choose_tag.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/notebook.dart';
import 'package:ppk/UI/goal_screen/top_part/wave_painter.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/request_constant/request_constant.dart';

import '../../../bloc/add_goal_model/global_goal_model.dart';
import '../../../bloc/calendar_bloc/calendar_bloc.dart';
import 'change_goal/change_goal_main_screen.dart';

class GlobalGoalsList extends StatelessWidget {
  List<GlobalGoalModel> goals;

  GlobalGoalsList(this.goals);

  List imagePath = [
    'assets/grey_global_goal.png',
    'assets/yellow_global_goal.png',
    'assets/orange_global_goal.png',
  ];

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return SizedBox(
      height: size.height / 1.6,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: size.width / 20, right: size.width / 20),
            height: size.height / 1.9,
            child: ListView.builder(
                physics: goals.length >= 4 ? ScrollPhysics() : NeverScrollableScrollPhysics(),
                itemCount: goals.length,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: size.height / 50),
                    child: Row(
                      mainAxisAlignment: index % 2 == 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => AddGoalBloc()
                                          ..add(Update(goals[index])),
                                      ),
                                      BlocProvider(
                                        create: (context) => CalendarBloc()
                                          ..add(
                                              CalendarEvent(goals[index].date)),
                                      ),
                                    ],
                                    child: ChangeGoalMainScreen(),
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    // Apply slide transition
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: size.width / 1.6,
                                  height: size.width / 3.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/goals_back_pattern.png'),
                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  width: size.width / 1.6,
                                  height: size.width / 3.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              tagColor[
                                                  goals[index].goalTags[0]]!,
                                              BlendMode.modulate),
                                          image: AssetImage(
                                              'assets/second_back_goal.png'),
                                          fit: BoxFit.fill)),
                                  child: Padding(
                                    padding: EdgeInsets.all(size.width / 70),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                  'до ${goals[index].date.day} ${monthNumberToName(goals[index].date.month)}',
                                                  style: theme
                                                      .textTheme.labelSmall!
                                                      .copyWith(
                                                          color: theme
                                                              .backgroundColor)),
                                            ),
                                            SizedBox(
                                              width: size.width / 3.5,
                                              child: Center(
                                                child: Text(
                                                    goals[index].goalTags[0],
                                                    style: theme
                                                        .textTheme.labelSmall),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(height: size.height / 100),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    right: size.width / 20),
                                                height: size.width / 6.5,
                                                width: size.width / 2.7,
                                                child: Text(
                                                  goals[index].name,
                                                  style: theme
                                                      .textTheme.labelSmall!
                                                      .copyWith(
                                                          color: theme
                                                              .primaryColor,
                                                      //     shadows: <Shadow>[
                                                      //   Shadow(
                                                      //       offset: Offset(
                                                      //           0.0, 3.0),
                                                      //       blurRadius: 8.0,
                                                      //       color: theme
                                                      //           .primaryColor
                                                      //           .withOpacity(
                                                      //               0.5)),
                                                      // ]
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                                height: size.width / 8,
                                                width: size.width / 8,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: theme.cardColor,
                                                        width: 2)),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: WaveAnimation(
                                                            size.width / 8,
                                                            theme.cardColor)),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          '${goals[index].subGoals.isEmpty ? 0 : (goals[index].subGoals.where((element) => element.isCompleted).length / goals[index].subGoals.length * 100).round()}%',
                                                          style: theme.textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: theme
                                                                      .backgroundColor)),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    // Navigate to the SecondScreen
                    return BlocProvider(
                        create: (context) => AddGoalBloc(), child: ChooseTag());
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      // Apply slide transition
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Center(
                child: Container(
              height: size.height / 12,
              width: size.height / 12,
              decoration: BoxDecoration(
                  color: Color(0xff433742).withOpacity(0.15),
                  border: Border.all(width: 5, color: theme.dividerColor),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.add_rounded,
                color: theme.dividerColor,
                size: size.height / 17,
              ),
            )),
          )
        ],
      ),
    );
  }
}
