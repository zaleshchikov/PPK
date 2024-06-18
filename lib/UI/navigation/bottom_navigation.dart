import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/choose_tag.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/in_news_world/news_world_main_screen.dart';
import 'package:ppk/UI/profile/profile.dart';
import 'package:ppk/bloc/profile/profile_bloc.dart';

import '../../bloc/add_goal_model/add_goal_bloc.dart';
import '../market/market_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen(this.body);

  Widget body;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    var listOfBody = [
      MarketScreen(),
      MainGoalScreen(),
      BlocProvider(
        create: (context) => AddGoalBloc(),
        child: Builder(builder: (context) {
          return ChooseTag();
        }),
      ),
      NewsWorld(),
      BlocProvider(
  create: (context) => ProfileBloc()..add(AddMyData()),
  child: Profile(),
),
      widget.body
    ];

    Widget BottomBarItem(String name, int index) {
      return InkWell(
          onTap: () => _onItemTapped(index),
          child: Container(
            height: size.height / 25,
            width: size.height / 25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/$name.png'),
                    fit: BoxFit.contain)),
          ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.primaryColor,
      body: Stack(
        children: [
          listOfBody[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height / 8.3,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.bottomAppBarColor,
                        borderRadius: BorderRadius.circular(1000),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffb9b2ad),
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 5  horizontally
                              5.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      height: size.height / 14,
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        child: Container(
                          height: size.height / 12,
                          color: theme.bottomAppBarColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BottomBarItem('search', 0),
                              BottomBarItem('check', 1),
                              Container(width: size.width / 10),
                              BottomBarItem('globus', 3),
                              BottomBarItem('user', 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AddGoalBloc(),
                                child: Builder(builder: (context) {
                                  return ChooseTag();
                                }),
                              ))),
                      child: Container(
                        height: size.height / 9,
                        width: size.height / 9,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/goal_cat.png'))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
