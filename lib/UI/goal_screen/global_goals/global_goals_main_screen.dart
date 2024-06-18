import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/bloc/global_goals/global_goals_bloc.dart';

import 'categories.dart';
import 'global_goals.dart';

class GlobalGoals extends StatelessWidget {
  const GlobalGoals({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    return Container(
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                'assets/global_goal_screen.png'
            ),
            fit: BoxFit.fill
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40)
        ),
      ),
      child: Column(
        children: [
          Container(height: size.height / 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Глобальные цели',
                  style: theme.textTheme.titleLarge!),
            ],
          ),
          Container(height: size.height / 50),
          Row(
            children: [
              Container(width: size.width / 20),
              Text(
                  'Категории',
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.textTheme.titleLarge!.color)),
            ],
          ),
          Categories(),
          BlocProvider(
            create: (context) =>
            GlobalGoalsBloc()
              ..add(updateData()),
            child: BlocBuilder<GlobalGoalsBloc, GlobalGoalsState>(
              builder: (context, state) {
                if(state.isLoading){
                  return Center(
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: theme.indicatorColor,
                          )));
                }
                if(!state.isSuccessRequest){
                  return Container(
                      height: size.height/1.7,
                      width: size.width,
                      child: Center(child: Text('Ошибка загрузки...')));
                }
                return GlobalGoalsList(state.goals);
              },
            ),
          )
        ],
      ),
    );
  }
}
