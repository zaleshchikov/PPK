import 'package:flutter/material.dart';
import 'package:ppk/UI/goal_screen/train/begin_train.dart';
import 'package:ppk/UI/in_news_world/goal_list/goals_by_tag.dart';
import 'package:ppk/request_constant/request_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routing_animation/animation_one.dart';
import '../../goal_screen/train/choose_begin.dart';

class GoalsListChooseTag extends StatelessWidget {
  const GoalsListChooseTag({super.key});

  Future isTrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [prefs.getBool('isNotChooseTagGoalsListTrain') ?? true, prefs];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var snapshot = await isTrain();
      if (snapshot[0]) {
        snapshot[1].setBool('isNotChooseTagGoalsListTrain', false);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => BeginTrain(
                1, 6, 'training/goals_list/goalswish', GoalsListChooseTag(), 1),
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      }
    });
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: size.height * 1.9,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width / 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/goals_list_choose_tag_back.png'),
                  fit: BoxFit.cover)),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                if(index == 0 || index == 11){
                  return Container(height: size.height/10);
                }
                return Row(
                  mainAxisAlignment: index % 2 == 1
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(AnimatedRouteOne(GoalsByTag(tags[index] as String, (tags[tags[index]] as int)-1)));
                      },
                      child: SizedBox(
                          height: size.height / 6,
                          width: size.height / 6,
                          child: Center(
                            child: Image.asset(
                                height: size.height / 6,
                                width: size.height / 6,
                                'assets/n${index}.png'),
                          )),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
