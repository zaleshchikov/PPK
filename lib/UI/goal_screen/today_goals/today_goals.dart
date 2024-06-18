import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ppk/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:ppk/bloc/today_goals/today_goals_form.dart';
import 'package:ppk/bloc/today_goals/today_golas_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TodayGoals extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    print('День изменен внутри TodayGoals');
    return BlocBuilder<TodayGoalsBloc, TodayGoalsState>(
      builder: (context, state) {
        Widget newTask = SizedBox(
            height: size.height / 11,
            width: size.width / 2,
            child: Center(
              child: ReactiveForm(
                formGroup: form,
                child: ReactiveTextField(
                    formControlName: 'text',
                    maxLength: 40,
                    textAlign: TextAlign.center,
                    cursorColor:
                    theme.primaryColor,
                    style: theme
                        .textTheme.bodyLarge!
                        .copyWith(
                        color: theme
                            .primaryColor),
                    onTapOutside: (_) {
                      BlocProvider.of<
                          TodayGoalsBloc>(
                          context)
                          .add(
                          TodayGoalsCloseTextFieldEvent());
                    },
                    onSubmitted: (_) {
                      BlocProvider.of<
                          TodayGoalsBloc>(
                          context)
                          .add(
                          TodayGoalsCloseTextFieldEvent());
                    },
                    decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none),
                    autofocus: true),
              ),
            ));



        return SizedBox(
          height: size.height / 1.6 -
              ((size.height /
                  11+ size.height/50) -
                  (size.height /
                      11+ size.height/50) *
                      (BlocProvider.of<TodayGoalsBloc>(context)
                                  .state
                                  .taskList
                                  .length >
                              4
                          ? 1
                          : BlocProvider.of<TodayGoalsBloc>(context)
                                  .state
                                  .taskList
                                  .length /
                              4)),
          child: Column(
            children: [
              SizedBox(
                height: (size.height /
                    11+ size.height/50)*4 *
                    (BlocProvider.of<TodayGoalsBloc>(context)
                                .state
                                .taskList
                                .length >
                            4
                        ? 1
                        : BlocProvider.of<TodayGoalsBloc>(context)
                                .state
                                .taskList
                                .length /
                            4),
                child: ListView.builder(
                  physics: state.taskList.length >= 4 ? ScrollPhysics() : NeverScrollableScrollPhysics(),
                  controller: ScrollController(
                    keepScrollOffset: false
                  ),
                    itemCount: state.taskList.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(size.height/100),
                        child: Container(
                          width: size.width / 1.2,
                          height: size.height / 11,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: index % 2 == 0
                                  ? theme.backgroundColor
                                  : theme.hoverColor),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<TodayGoalsBloc>(context)
                                      .add(TodayGoalsChangeDoneStatusEvent(
                                          index));
                                },
                                child: Icon(
                                    state.taskList[index].done
                                        ? Icons.check_circle_outline
                                        : Icons.circle_outlined,
                                    size: size.width / 8,
                                    color: theme.primaryColor),
                              ),
                              (state.lastIsNew &&
                                      index == 0)
                                  ? newTask
                                  : state.indexOfChangeingTask == index ? SizedBox(
                                  height: size.height / 11,
                                  width: size.width / 2,
                                  child: Center(
                                    child: ReactiveForm(
                                      formGroup: form,
                                      child: ReactiveTextField(
                                          formControlName: 'text',
                                          maxLength: 40,
                                          textAlign: TextAlign.center,
                                          cursorColor:
                                          theme.primaryColor,
                                          style: theme
                                              .textTheme.bodyLarge!
                                              .copyWith(
                                              color: theme
                                                  .primaryColor),
                                          onTapOutside: (_) {
                                            BlocProvider.of<
                                                TodayGoalsBloc>(
                                                context)
                                                .add(
                                                TodayGoalsChangeNameTaskEvent(index));
                                          },
                                          onSubmitted: (_) {
                                            BlocProvider.of<
                                                TodayGoalsBloc>(
                                                context)
                                                .add(
                                                TodayGoalsChangeNameTaskEvent(index));
                                          },
                                          decoration: const InputDecoration(
                                              counterText: '',
                                              border: InputBorder.none),
                                          autofocus: true),
                                    ),
                                  )) : SizedBox(
                                      width: size.width / 2,
                                      child: Center(
                                          child: Text(
                                              state.taskList[index].name,
                                              style: theme
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColor,
                                                      decoration: state
                                                              .taskList[
                                                                  index]
                                                              .done
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration
                                                              .none)))),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<TodayGoalsBloc>(context)
                                      .add(
                                          TodayGoalsChangeTaskEvent(index));
                                },
                                child: Icon(Icons.chevron_right,
                                    size: size.width / 8,
                                    color: theme.primaryColor),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Container(height: size.height/20),
              Center(
                  child: InkWell(
                onTap: () {
                  BlocProvider.of<TodayGoalsBloc>(context)
                      .add(TodayGoalsOpenTextFieldEvent());
                },
                child: Container(
                  height: size.height / 12,
                  width: size.height / 12,
                  decoration: BoxDecoration(
                      color: const Color(0xff433742).withOpacity(0.15),
                      border:
                          Border.all(width: 5, color: theme.dividerColor),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.add_rounded,
                    color: theme.dividerColor,
                    size: size.height / 17,
                  ),
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
