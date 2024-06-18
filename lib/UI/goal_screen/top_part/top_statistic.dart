import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/top_part/wave_painter.dart';

import '../../../bloc/today_goals/today_golas_bloc.dart';

class TopStatistic extends StatelessWidget {
  const TopStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocBuilder<TodayGoalsBloc, TodayGoalsState>(
      builder: (context, state) {
        print(state.taskList.length);
        return Container(
          height: size.width * 465 / 550,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  width: size.width,
                  height: size.width * 465 / 550,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/top_statistic_back.png'),
                          fit: BoxFit.fitWidth)),
                ),
              ),
              Positioned(
                  top: size.width / 5,
                  left: size.width / 30,
                  right: size.width / 30,
                  child: Text(
                    'Молодец\nОсталось чуть-чуть.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  )),
              Positioned(
                  bottom: size.width / 40,
                  left: size.width / 4,
                  right: size.width / 4,
                  child: Container(
                    height: size.width / 3.6,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: size.width / 35, color: theme.cardColor)),
                    child: Center(
                        child: WaveAnimation(
                            size.width / 3.6 - size.width / 35 * 2,
                            theme.highlightColor)),
                  )),
              Positioned(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: size.width / 3.6 + size.width / 35 * 2,
                          width: size.width / 3.6,
                          child: Center(
                              child: Text(
                            '${state.taskList.isEmpty ? 0 : (((state.taskList.where((e) => e.done)).length / state.taskList.length)*100).round()}%',
                            style: theme.textTheme.titleMedium,
                          )))))
            ],
          ),
        );
      },
    );
  }
}
