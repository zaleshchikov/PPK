import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/goal_status.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/main_photo.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';

class GoalPhoto extends StatelessWidget {
  GoalPhoto({super.key});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.hoverColor,
      appBar: AppBar(
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
                        image: AssetImage('assets/close_notebook.png'))),
              ),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width,
                height: size.width * 1.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/global_goal_photo_back.png'),
                        fit: BoxFit.fitWidth)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainPhoto('', bytesList: null,),
                        Container(width: size.width/10)
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (contemxt, animation, secondaryAnimation) {
                                    // Navigate to the SecondScreen
                                    return BlocProvider.value(
                                      value: BlocProvider.of<AddGoalBloc>(context),
                                      child: GoalStatus(),
                                    );
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

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
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (contemxt, animation, secondaryAnimation) {
                                    // Navigate to the SecondScreen
                                    return BlocProvider.value(
                                      value: BlocProvider.of<AddGoalBloc>(context),
                                      child: GoalStatus(),
                                    );
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

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
                                      BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      'Далее',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                          color: theme.textTheme
                                              .titleLarge!.color),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Container(height: size.height / 50),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
