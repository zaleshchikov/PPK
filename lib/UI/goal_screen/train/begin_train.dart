import 'package:flutter/material.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/goal_screen/train/choose_begin.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';

class BeginTrain extends StatelessWidget {
  int index;
  int maxIndex;
  String imagePatter;
  Widget finalWidget;
  int trainIndex;
  BeginTrain(this.index, this.maxIndex, this.imagePatter, this.finalWidget, this.trainIndex);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Material(
      child: InkWell(
        onTap: () {
          index++;
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => (index == 2 && imagePatter != 'training/goals_list/goalswish') || index == maxIndex
                  ? index == maxIndex
                      ? finalWidget
                      : ChooseTrain(index+1,maxIndex, imagePatter, finalWidget)
                  : BeginTrain(index, maxIndex, imagePatter, finalWidget, trainIndex),
              transitionDuration: Duration(milliseconds: 400),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        },
        child: Scaffold(
            body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/${imagePatter}$index.png'), fit: BoxFit.fill)),
        )),
      ),
    );
  }
}
