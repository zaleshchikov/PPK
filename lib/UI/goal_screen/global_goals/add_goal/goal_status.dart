import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';

class GoalStatus extends StatefulWidget {
  const GoalStatus({super.key});

  @override
  State<GoalStatus> createState() => _GoalStatusState();
}

class _GoalStatusState extends State<GoalStatus> {
  int _index = 0;
  List<String> assetsPaths = [
    'assets/privat.png',
    'assets/public.png',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocListener<AddGoalBloc, GlobalGoalModel>(
      listener: (context, state) {
        if (state.isSuccessRequest) {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return BottomNavigationScreen(MainGoalScreen());
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                // Apply slide transition
                position: offsetAnimation,
                child: child,
              );
            },
          ));
        }
      },
      child: Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Выберите тег',
                style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.textTheme.titleLarge!.color,
                    fontSize: theme.textTheme.titleMedium!.fontSize! * 1.2)),
            Container(
              height: size.height / 2.5,
              width: size.width,
              child: PageView.builder(
                itemCount: 2,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) {
                  return AnimatedPadding(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.all(_index == index ? 0.0 : 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      elevation: 4,
                      child: Container(
                        height: size.height / 2.5,
                        width: size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(assetsPaths[index]),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(height: size.height / 50),
            BlocBuilder<AddGoalBloc, GlobalGoalModel>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<AddGoalBloc>(context)
                        .add(AddPrivate(_index == 0));
                    BlocProvider.of<AddGoalBloc>(context)
                        .add(SendData());
                  },
                  child: Center(
                      child: Container(
                    width: size.width / 2.1,
                    height: size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: theme.hintColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child:
                          state.isLoading
                              ? Center(
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        color: theme.backgroundColor,
                                      )))
                              : Text(
                                  'Выбрать',
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      color: theme.textTheme.titleLarge!.color),
                                ),
                    ),
                  )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
