import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/global_goal_screen/comment_view.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/calendar_add_goal.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/main_photo.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/subgoals.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/change_goal_note.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/tags.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:ppk/bloc/comments/comment_model.dart';
import 'package:ppk/bloc/comments/comments_bloc.dart';
import 'package:ppk/bloc/global_goals/global_goals_bloc.dart';
import 'package:ppk/bloc/subgoals/subgoals_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';
import '../../../../bloc/calendar_bloc/calendar_bloc.dart';
import '../../../../request_constant/request_constant.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/choose_tag.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/add_date.dart';
import '../goal_screen/global_goals/add_goal/choose_tag.dart';

class GlobalGoalMainScreen extends StatefulWidget {
  bool istop = true;
  int commentsCount = 4;

  @override
  State<GlobalGoalMainScreen> createState() => _GlobalGoalMainScreenState();
}

class _GlobalGoalMainScreenState extends State<GlobalGoalMainScreen> {
  ScrollController _controller = ScrollController();

  void scroll(double position) {
    _controller.animateTo(1000,
        curve: Curves.ease, duration: Duration(milliseconds: 10000));
  }

  @override
  void initState() {
    super.initState();
    !widget.istop
        ? WidgetsBinding.instance.addPostFrameCallback((_) => scroll(10000))
        : print(1);
    setState(() {
      widget.istop = false;
    });
  }

  Timer? timer;
  final form = FormGroup({
    'text': FormControl<String>(),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocBuilder<AddGoalBloc, GlobalGoalModel>(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SubGoalsBloc(),
            ),
            BlocProvider(
              create: (context) => CommentsBloc()
                ..add(GetComments(
                    BlocProvider.of<AddGoalBloc>(context).state.goalId)),
            ),
          ],
          child: Builder(builder: (context) {
            if (timer == null && state.goalId != 0) {
              timer = Timer.periodic(
                  Duration(seconds: 2),
                  (Timer t) => BlocProvider.of<CommentsBloc>(context)
                      .add(GetComments(state.goalId)));
            }
            BlocProvider.of<CommentsBloc>(context).add(GetComments(
                BlocProvider.of<AddGoalBloc>(context).state.goalId));
            return BlocBuilder<CommentsBloc, CommentsState>(
              builder: (context, commentState) {
                return SingleChildScrollView(
                  controller: _controller,
                  child: Material(
                    child: Container(
                      color: Color(0xffF8EEE2),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 10),
                            color: Color(0xffF8EEE2),
                            child: Column(
                              children: [
                                AppBar(
                                    backgroundColor: Colors.transparent,
                                    leading: Container(
                                      padding: EdgeInsets.only(
                                          left: size.width / 20),
                                      child: InkWell(
                                        onTap: () {
                                          if (timer != null) {
                                            timer!.cancel();
                                          }
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
                                Container(height: size.height / 100),
                                Container(
                                    height: size.height / 20,
                                    width: size.width,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          child: Row(
                                            children: [
                                              Text(
                                                  'Выполнено ${state.subGoals.isEmpty ? 0 : (((state.subGoals.where((e) => e.isCompleted)).length / state.subGoals.length) * 100).round()}%',
                                                  style: theme
                                                      .textTheme.labelSmall!
                                                      .copyWith()),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                              color: Color(0xff9C8E87)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: size.height / 200,
                                                width: size.width *
                                                    0.8 *
                                                    (state.subGoals.isEmpty
                                                        ? 0.01
                                                        : (((state.subGoals
                                                                    .where((e) =>
                                                                        e.isCompleted))
                                                                .length /
                                                            state.subGoals
                                                                .length))),
                                                decoration: BoxDecoration(
                                                  color: Color(0xffF26C43),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
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
                                    )),
                                Container(
                                    height: size.width * 0.8,
                                    width: size.width * 0.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Color(0xffDDD2C7)),
                                    child: state.mainPhoto == ''
                                        ? Container()
                                        : Image.memory(
                                            Uint8List.fromList([]),
                                            fit: BoxFit.cover,
                                          )),
                                Container(height: size.height / 50),
                                Center(
                                    child: Text(state.name,
                                        style: theme.textTheme.titleLarge)),
                                Container(height: size.height / 30),
                                Center(
                                    child: Text(state.text,
                                        style: theme.textTheme.bodyLarge)),
                                Container(height: size.height / 30),
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
                                Center(child: TagsList.OnlyRead()),
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
                                Center(
                                    child: Container(
                                        child: SubGoalsList.ReadOnly())),
                                Container(height: size.height / 50),
                              ],
                            ),
                          ),
                          Container(
                            constraints:
                                BoxConstraints(minHeight: size.height / 4),
                            decoration: BoxDecoration(
                              color: Color(0xffDDD2C7),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(height: size.height / 50),
                                Center(
                                  child: Text(
                                    'Комментарии',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme
                                                .textTheme.titleLarge!.color),
                                  ),
                                ),
                                Container(height: size.height / 100),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: commentState.comments.length > 3
                                          ? 0
                                          : MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                  child: ReactiveForm(
                                    formGroup: this.form,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: size.width * 0.6,
                                            height: size.height / 14,
                                            child: ReactiveTextField(
                                              onTap: (_) {
                                                SchedulerBinding.instance
                                                    ?.addPostFrameCallback(
                                                        (_) async {
                                                  await Future.delayed(Duration(
                                                      milliseconds: 500));
                                                  _controller.jumpTo(_controller
                                                      .position
                                                      .maxScrollExtent);
                                                });
                                              },
                                              cursorColor: Color(0x99747474),
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      color: Color(0x99747474)),
                                              maxLines: 1000,
                                              decoration: InputDecoration(
                                                hintText: 'Введите комметарий',
                                                hintStyle: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        color:
                                                            Color(0x99747474)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color(0x99747474)),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color(0x99747474)),
                                                ),
                                              ),
                                              formControlName: 'text',
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (form.control('text').value !=
                                                      null &&
                                                  form.control('text').value !=
                                                      '') {
                                                BlocProvider.of<CommentsBloc>(
                                                        context)
                                                    .add(WriteComment(
                                                        form
                                                            .control('text')
                                                            .value,
                                                        state.goalId));
                                                BlocProvider.of<CommentsBloc>(
                                                        context)
                                                    .add(GetComments(
                                                        state.goalId));
                                              }
                                              form.unfocus();
                                              form.markAsUntouched();
                                              form.control('text').value = '';
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.send,
                                              color: Color(0x99747474),
                                              size: size.height / 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Column(
                                        children: List.from(commentState
                                            .comments
                                            .map((e) => CommentView(e))
                                            .toList()
                                            .reversed)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}
