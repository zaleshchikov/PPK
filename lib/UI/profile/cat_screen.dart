import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/today_goals/today_goals.dart';
import 'package:ppk/UI/profile/profile.dart';
import 'package:ppk/bloc/today_goals/today_golas_bloc.dart';

import '../goal_screen/top_part/main_goal_screen.dart';
import '../navigation/bottom_navigation.dart';

class CatScreen extends StatelessWidget {
  String backPath;
  String name;
  bool status;

  CatScreen(this.backPath, this.name, this.status);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backPath), fit: BoxFit.cover
          ),
        ),
        height: size.height,
        width: size.width,
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Container(
                padding: EdgeInsets.only(left: size.width / 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return BottomNavigationScreen(Profile());
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                      ),
                    );
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
            children: [
              Container(
                height: size.height / 5,
              ),
              Center(
                child: Text(name, style: theme.textTheme.titleLarge),
              ),
              BlocProvider(
                create: (context) => TodayGoalsBloc()..add(TodayGoalsGetDateAndStatusEvent(DateTime.now(), status)),
                child: TodayGoals(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
