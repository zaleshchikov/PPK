import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/train/choose_begin.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/UI/profile/cat_screen_global.dart';
import 'package:ppk/UI/profile/top_profile.dart';
import 'package:ppk/UI/profile/cat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/global_goals/global_goals_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future isTrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [prefs.getBool('isNotProfileTrain') ?? true, prefs];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    // WidgetsBinding.instance
    //     .addPostFrameCallback(
    //     (_) async {
    //       var snapshot = await isTrain();
    //       if (snapshot[0]) {
    //         snapshot[1].setBool('isNotProfileTrain', false);
    //         Navigator.push(
    //           context,
    //           PageRouteBuilder(
    //             pageBuilder: (_, __, ___) => ChooseTrain(2, 7, 'training/profile/профиль',
    //                 BottomNavigationScreen(BlocProvider.value(
    //                   value: BlocProvider.of<ProfileBloc>(context),
    //                   child: Profile(),
    //                 ))),
    //             transitionDuration: Duration(milliseconds: 400),
    //             transitionsBuilder: (_, a, __, c) =>
    //                 FadeTransition(opacity: a, child: c),
    //           ),
    //         );
    //       }
    //     }
    // );
    BlocProvider.of<ProfileBloc>(context).add(CheckSubscribe(BlocProvider.of<ProfileBloc>(context).state.id));
          return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: size.height * 1.2,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/profile_back.png'),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                Container(
                height: size.width * 465 / 720,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          width: size.width,
                          height: size.width * 465 / 720,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/top_profile.png'),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                      Positioned(
                          top: size.width / 3,
                          left: size.width / 30,
                          right: size.width / 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: size.width / 20,
                              ),
                              Image(
                                  height: size.height / 10,
                                  width: size.height / 10,
                                  image: AssetImage('assets/cat_ava.png')),
                              Container(
                                    height: size.height/10,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: size.width/2,
                                          child: AutoSizeText(
                                            maxLines: 1,
                                            state.nickname,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                color: theme.textTheme.bodyMedium!.color),
                                          ),
                                        ),
                                        state.isMe ? Container() : InkWell(
                                          onTap: (){
                                            BlocProvider.of<ProfileBloc>(context).add(Subscribe(state.id));
                                            BlocProvider.of<ProfileBloc>(context).add(CheckSubscribe(BlocProvider.of<ProfileBloc>(context).state.id));
                                          },
                                          child: Container(
                                            width: size.width / 3,
                                            height: size.height / 20,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(
                                                        0, 3), // changes position of shadow
                                                  ),
                                                ],
                                                color: theme.backgroundColor,
                                                borderRadius: BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                  state.isSubsribed ? 'Отписаться' : 'Подписаться',
                                                  style: theme.textTheme.labelSmall
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                              ),
                              Container(
                                width: size.width / 20,
                              ),
                            ],
                          )),
                      Positioned(
                          top: size.width / 8,
                          left: size.width / 30,
                          right: size.width / 30,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: size.width / 40,
                              ),
                              // Image(
                              //     height: size.height/18,
                              //     width: size.height/18,
                              //     image: AssetImage('assets/drawer_icon.png')),
                              Container(
                                width: size.width / 1.7,
                              ),
                              // Image(
                              //     height: size.height/18,
                              //     width: size.height/18,
                              //     image: AssetImage('assets/edit_profile.png')),
                              Container(
                                width: size.width / 40,
                              ),
                            ],
                          )),
                      state.isMe ? Container() : Positioned(
                        top: size.height/20,
                        left: size.width/10,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: size.height/25,
                            height: size.height/25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/close.png'),
                                    fit: BoxFit.fitWidth)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                    Container(height: size.height / 50),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width / 15, right: size.width / 15),
                      child: Column(
                        children: [
                         !state.isMe ? Container() : Center(
                            child: Text(
                              'Задачи',
                              style: theme.textTheme.titleLarge!.copyWith(
                                  fontSize:
                                      theme.textTheme.titleLarge!.fontSize! /
                                          1.4),
                            ),
                          ),
                          !state.isMe ? Container() : Container(height: size.height / 50),
                          !state.isMe ? Container() : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return CatScreen('assets/todoback.png',
                                            'Сделать', false);
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
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
                                  height: size.width / 2.5,
                                  width: size.width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/profile/todo_profile.png'))),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return CatScreen('assets/done_back.png',
                                            'Готово', true);
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
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
                                  height: size.width / 2.5,
                                  width: size.width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/profile/done_profile.png'))),
                                ),
                              ),
                            ],
                          ),
                          !state.isMe ? Container() : Container(height: size.height / 10),
                          Center(
                            child: Text(
                              'Глобальные цели',
                              style: theme.textTheme.titleLarge!.copyWith(
                                  fontSize:
                                      theme.textTheme.titleLarge!.fontSize! /
                                          1.4),
                            ),
                          ),
                          Container(height: size.height / 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return BlocProvider(
                                          create: (context) => GlobalGoalsBloc()
                                            ..add(updateDataPercent(0, state.isMe, state.id)),
                                          child: Builder(builder: (context) {
                                            return BlocBuilder<GlobalGoalsBloc,
                                                GlobalGoalsState>(
                                              builder: (context, state) {
                                                return CatScreenGlobal(
                                                    'assets/inplans.png',
                                                    'В планах',
                                                    state.goals);
                                              },
                                            );
                                          }),
                                        );
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
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
                                  height: size.width / 2.5,
                                  width: size.width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/profile/plans_profile.png'))),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return BlocProvider(
                                            create: (context) => GlobalGoalsBloc()
                                              ..add(updateDataPercent(1, state.isMe, state.id)),
                                            child: Builder(builder: (context) {
                                              return BlocBuilder<GlobalGoalsBloc,
                                                  GlobalGoalsState>(
                                                builder: (context, state) {
                                                  return CatScreenGlobal(
                                                      'assets/inprocess.png',
                                                      'В процессе',
                                                      state.goals);
                                                },
                                              );
                                            }),
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;
                                          var tween = Tween(
                                              begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                          animation.drive(tween);
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
                                  height: size.width / 2.5,
                                  width: size.width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/profile/process_profile.png'))),
                                ),
                              ),
                            ],
                          ),
                          Container(height: size.height / 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return BlocProvider(
                                          create: (context) => GlobalGoalsBloc()
                                            ..add(updateDataPercent(2, state.isMe, state.id)),
                                          child: Builder(builder: (context) {
                                            return BlocBuilder<GlobalGoalsBloc,
                                                GlobalGoalsState>(
                                              builder: (context, state) {
                                                return CatScreenGlobal(
                                                    'assets/completed....png',
                                                    'Достигнуты',
                                                    state.goals);
                                              },
                                            );
                                          }),
                                        );
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                        animation.drive(tween);
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
                                  height: size.width / 2.5,
                                  width: size.width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/profile/success_profile.png'))),
                                ),
                              ),
                            ],
                          ),
                          // Container(height: size.height / 20),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Книга глобальных целей',
                          //       style: theme.textTheme.titleLarge!.copyWith(
                          //           fontSize:
                          //               theme.textTheme.titleLarge!.fontSize! /
                          //                   1.4),
                          //     ),
                          //   ],
                          // ),
                          // Container(height: size.height / 30),
                          // Container(
                          //   height: size.width / 1.5,
                          //   width: size.width / 1.5,
                          //   decoration: BoxDecoration(
                          //       color: Colors.transparent,
                          //       borderRadius: BorderRadius.circular(30),
                          //       image: DecorationImage(
                          //           image:
                          //               AssetImage('assets/profile/book.png'))),
                          // ),
                          Container(height: size.height / 30),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Статистика',
                          //       style: theme.textTheme.titleLarge!.copyWith(
                          //           fontSize:
                          //               theme.textTheme.titleLarge!.fontSize! /
                          //                   1.2),
                          //     ),
                          //   ],
                          // ),
                          // Container(height: size.height / 40),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Image(
                          //       image: AssetImage('assets/active_days.png'),
                          //       height: size.height / 5,
                          //       fit: BoxFit.fitHeight,
                          //     ),
                          //     Image(
                          //       image: AssetImage('assets/active_days.png'),
                          //       height: size.height / 5,
                          //       fit: BoxFit.fitHeight,
                          //     )
                          //   ],
                          // )
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
  }
}
