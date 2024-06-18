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
import 'package:ppk/routing_animation/animation_one.dart';

import '../../../bloc/add_goal_model/global_goal_model.dart';

class UsersGoals extends StatelessWidget {
  List<GlobalGoalModel> goals;

  UsersGoals(this.goals);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return SizedBox(
      height: size.height / 1.55,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: size.width / 20, right: size.width / 20),
            height: size.height / 1.55,
            child: ListView.builder(
                itemCount: goals.length,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: size.height / 50),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(AnimatedRouteOne(BlocProvider(
                            create: (context) =>
                                AddGoalBloc()..add(Update(goals[index])),
                            child: GlobalGoalMainScreen(),
                          )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height / 5.5,
                            decoration: BoxDecoration(
                              color: tagColor[goals[index].goalTags[0]],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: size.height / 6,
                                  width: size.width * 0.3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: size.height / 8,
                                        width: size.height / 8,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      Container(
                                        child: Text(
                                            'до ${goals[index].date.day} ${monthNumberToName(goals[index].date.month)}',
                                            style: theme.textTheme.labelSmall!
                                                .copyWith()),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height / 5.5,
                                  width: size.width * 0.4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: size.height / 40,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: size.width / 3,
                                              child: Text(goals[index].name,
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: theme
                                                              .primaryColor)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height / 20,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: size.width / 3,
                                              height: size.height / 20,
                                              child: Text(goals[index].text,
                                                  style: theme
                                                      .textTheme.labelSmall!
                                                      .copyWith(
                                                          color: theme
                                                              .backgroundColor)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            margin: EdgeInsets.zero,
                                            child: Row(
                                              children: [
                                                Text(
                                                    'Выполнено ${goals[index].subGoals.isEmpty ? 0 : (((goals[index].subGoals.where((e) => e.isCompleted)).length / goals[index].subGoals.length) * 100).round()}%',
                                                    style: theme
                                                        .textTheme.labelSmall!
                                                        .copyWith(
                                                            color: theme
                                                                .backgroundColor)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.zero,
                                            margin: EdgeInsets.zero,
                                            height: size.height / 200,
                                            width: size.width / 2.6,
                                            decoration: BoxDecoration(
                                                color: Color(0xff9C8E87)
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: size.height / 200,
                                                  width: size.width /
                                                      2.6 *
                                                      (goals[index]
                                                              .subGoals
                                                              .isEmpty
                                                          ? 0.01
                                                          : (((goals[index]
                                                                      .subGoals
                                                                      .where((e) =>
                                                                          e.isCompleted))
                                                                  .length /
                                                              goals[index]
                                                                  .subGoals
                                                                  .length))),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFEF4E8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
