import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/goal_photo.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/subgoals.dart';
import 'package:ppk/UI/goal_screen/today_goals/today_goals.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/bloc/subgoals/subgoals_bloc.dart';
import 'package:ppk/bloc/today_goals/today_golas_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SubGoals extends StatelessWidget {
  SubGoals({super.key});

  final form = FormGroup({
    'name': FormControl<String>(),
    'description': FormControl<String>(),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => SubGoalsBloc()
        ..add(SubGoalsGetDate(
            BlocProvider.of<AddGoalBloc>(context)
                .state
                .name)),
      child: Builder(builder: (context) {
        return Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: theme.hoverColor,
                appBar: AppBar(
                    toolbarHeight: size.height / 20,
                    backgroundColor: theme.hoverColor,
                    leading: Container(
                      padding: EdgeInsets.only(left: size.width / 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: size.width * 0.08,
                          height: size.width * 0.08,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/close_notebook.png'))),
                        ),
                      ),
                    )),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          'План действий',
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.textTheme.titleLarge!.color)),
                    ),
                    Container(height: size.height / 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width / 1,
                          height: size.width * 1.65,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/notebook.png'),
                                  fit: BoxFit.fitHeight)),
                          child: Container(
                            padding: EdgeInsets.only(left: size.width / 5),
                            child: Column(
                              children: [
                                Container(height: size.height / 100),
                                Row(
                                  children: [
                                    Text('Шаги',
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color: theme.textTheme
                                                    .titleLarge!.color)),
                                  ],
                                ),
                                Container(height: size.height / 100),
                                Row(
                                  children: [
                                    Text(
                                        'Здесь вы можете составить пошаговый\nплан достижения цели с помощью\nразделения на под-цели',
                                        style: theme.textTheme.labelSmall),
                                  ],
                                ),
                                Container(height: size.height / 100),
                                Builder(builder: (context) {
                                  return SingleChildScrollView(
                                    child: SizedBox(
                                      height: size.height / 2.5,
                                      child: SubGoalsList.IsShirt(),
                                    ),
                                  );
                                }),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(PageRouteBuilder(
                                          pageBuilder: (contemxt, animation,
                                              secondaryAnimation) {
                                            // Navigate to the SecondScreen
                                            return BlocProvider.value(
                                              value:
                                                  BlocProvider.of<AddGoalBloc>(
                                                      context),
                                              child: GoalPhoto(),
                                            );
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.easeInOut;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);

                                            return SlideTransition(
                                              // Apply slide transition
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        child: Center(
                                            child: Container(
                                          width: size.width / 3,
                                          height: size.width / 6,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: Color(0xffEEE6DD),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text(
                                              'Пропустить',
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      color: theme.textTheme
                                                          .titleLarge!.color),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ),
                                    BlocBuilder<SubGoalsBloc, SubGoalsState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          onTap: () {
                                            BlocProvider.of<AddGoalBloc>(
                                                    context)
                                                .add(AddSubGoals(
                                                    state.taskList));
                                            print(state.taskList);
                                            Navigator.of(context)
                                                .push(PageRouteBuilder(
                                              pageBuilder: (contemxt, animation,
                                                  secondaryAnimation) {
                                                // Navigate to the SecondScreen
                                                return BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      AddGoalBloc>(context),
                                                  child: GoalPhoto(),
                                                );
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                const begin = Offset(1.0, 0.0);
                                                const end = Offset.zero;
                                                const curve = Curves.easeInOut;
                                                var tween = Tween(
                                                        begin: begin, end: end)
                                                    .chain(CurveTween(
                                                        curve: curve));
                                                var offsetAnimation =
                                                    animation.drive(tween);

                                                return SlideTransition(
                                                  // Apply slide transition
                                                  position: offsetAnimation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                right: size.width / 10),
                                            child: Center(
                                                child: Container(
                                              width: size.width / 3,
                                              height: size.width / 5,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: theme.hintColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Center(
                                                child: Text(
                                                  'Далее',
                                                  style: theme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: theme
                                                              .textTheme
                                                              .titleLarge!
                                                              .color),
                                                ),
                                              ),
                                            )),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
