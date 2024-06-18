import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:ppk/bloc/subgoals/subgoals_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../bloc/subgoals/sub_goals_form.dart';

class SubGoalsList extends StatelessWidget {

  bool readOnly = false;
  bool isShort = false;

  SubGoalsList();
  SubGoalsList.ReadOnly(){
    this.readOnly = true;
  }

  SubGoalsList.IsShirt(){
    this.isShort = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocBuilder<SubGoalsBloc, SubGoalsState>(
      builder: (context, state) {
        if(state.taskList.isEmpty)BlocProvider.of<SubGoalsBloc>(context).add(SubGoalsAddExistingGoals(BlocProvider.of<AddGoalBloc>(context).state.subGoals));
        Widget newTask = SizedBox(
            height: size.width / 5,
            width: size.width / 2.5,
            child: Center(
              child: ReactiveForm(
                formGroup: form,
                child: ReactiveTextField(
                  readOnly: readOnly,
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
                          SubGoalsBloc>(
                          context)
                          .add(
                          SubGoalsCloseTextField());
                    },
                    onSubmitted: (_) {
                      BlocProvider.of<
                          SubGoalsBloc>(
                          context)
                          .add(
                          SubGoalsCloseTextField());
                    },
                    decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none),
                    autofocus: true),
              ),
            ));

        return Container(height: size.height / 1.5 -
              (size.height / 2 -
                  size.height /
                      2 *
                      (BlocProvider.of<SubGoalsBloc>(context)
                          .state
                          .taskList
                          .length >
                          (isShort ? 8 : 4)
                          ? 1
                          : BlocProvider.of<SubGoalsBloc>(context)
                          .state
                          .taskList
                          .length /
                          (isShort ? 8 : 4))),
          child: Column(
            children: [
              SizedBox(
                height: size.height /
                    2 *
                    (BlocProvider.of<SubGoalsBloc>(context)
                        .state
                        .taskList
                        .length >
                        (isShort ? 8 : 4)
                        ? 1
                        : BlocProvider.of<SubGoalsBloc>(context)
                        .state
                        .taskList
                        .length /
                        (isShort ? 8 : 4)),
                child: ListView.builder(
                    controller: ScrollController(
                        keepScrollOffset: false
                    ),
                    itemCount: state.taskList.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: size.width / 1.2,
                          height: size.width / 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: theme.backgroundColor),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  readOnly ? print('') :BlocProvider.of<SubGoalsBloc>(context)
                                      .add(SubGoalsChangeDoneStatus(
                                      index));
                                },
                                child: Icon(
                                    state.taskList[index].isCompleted
                                        ? Icons.check_circle_outline
                                        : Icons.circle_outlined,
                                    size: size.width / 8,
                                    color: theme.primaryColor),
                              ),
                              (state.lastIsNew &&
                                  index == 0)
                                  ? newTask
                                  : state.indexOfChangeingTask == index ? SizedBox(
                                  height: size.width / 5,
                                  width: size.width / 2.5,
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
                                                SubGoalsBloc>(
                                                context)
                                                .add(
                                                SubGoalsChangeNameTask(index));
                                          },
                                          onSubmitted: (_) {
                                            BlocProvider.of<
                                                SubGoalsBloc>(
                                                context)
                                                .add(
                                                SubGoalsChangeNameTask(index));
                                          },
                                          decoration: const InputDecoration(
                                              counterText: '',
                                              border: InputBorder.none),
                                          autofocus: true),
                                    ),
                                  )) : SizedBox(
                                  width: size.width / 2.5,
                                  child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                          state.taskList[index].name,
                                          style: theme
                                              .textTheme.bodyLarge!
                                              .copyWith(
                                              color: theme
                                                  .primaryColor,
                                              decoration: state
                                                  .taskList[
                                              index]
                                                  .isCompleted
                                                  ? TextDecoration
                                                  .lineThrough
                                                  : TextDecoration
                                                  .none)))),
                              InkWell(
                                onTap: () {
                                  readOnly ? print('') : BlocProvider.of<SubGoalsBloc>(context)
                                      .add(
                                      SubGoalsChangeTask(index));
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
              Container(
                height: size.height / 20,
              ),
             readOnly ? Container() : Center(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<SubGoalsBloc>(context)
                          .add(SubGoalsOpenTextField());
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
