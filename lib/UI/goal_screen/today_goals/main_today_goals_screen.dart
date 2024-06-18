import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/today_goals/calendar.dart';
import 'package:ppk/UI/goal_screen/today_goals/today_goals.dart';
import 'package:ppk/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:ppk/bloc/today_goals/today_golas_bloc.dart';

class MainTodayGoalsScreen extends StatelessWidget {
  const MainTodayGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    return SizedBox(
      child: Column(
        children: [
          Container(height: size.height / 50),
          Container(
            height: size.height / 70,
            width: size.width / 3,
            decoration: BoxDecoration(
                color: theme.backgroundColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30)
            ),
          ),
          Container(height: size.height / 100),
          Container(
              padding: EdgeInsets.only(left: size.width/50, right: size.width/50),
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(1000)),
              child: Calendar()),
          Container(height: size.height / 50),
          Row(
            children: [
              Container(width: size.width / 15,),
              Text(
                  'Сделать',
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.primaryColor)),
            ],
          ),
          Container(height: size.height / 50),
          TodayGoals(),
        ],
      ),
    );
  }
}
