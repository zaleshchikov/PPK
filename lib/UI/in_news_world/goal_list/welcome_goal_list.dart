import 'package:flutter/material.dart';
import 'package:ppk/UI/in_news_world/goal_list/goals_list_choose_tag.dart';
import 'package:ppk/UI/in_news_world/news_world_main_screen.dart';

import '../../../routing_animation/animation_one.dart';
import '../../goal_screen/top_part/main_goal_screen.dart';
import '../../navigation/bottom_navigation.dart';

class WelcomeGoalList extends StatelessWidget {
  const WelcomeGoalList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/подводка.png'
          ), fit: BoxFit.cover
        )
      ),
      child: Scaffold(
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
                        return BottomNavigationScreen(NewsWorld());
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
                          image: AssetImage(
                              'assets/close_notebook.png'))),
                ),
              ),
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width/8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: size.height/50),
              Container(
                  height: size.height/6,
                  child: Image(image: AssetImage('assets/sasha.png'))),
              Row(
                children: [
                  Text('Список готовых\nглобальных\nцелей', textAlign: TextAlign.left, style: theme.textTheme.titleLarge),
                ],
              ),
              Row(
                children: [
                  Text('Выбирай цель по душе и\nдостигай результатов', textAlign: TextAlign.left, style: theme.textTheme.bodySmall),
                ],
              ),
              Container(height: size.height/100),
              Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(AnimatedRouteOne(GoalsListChooseTag()));
                    },
                    child: Container(
                      width: size.width / 2.1,
                      height: size.width / 4,
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
                          color: Color(0xffC6A094),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Поехали',
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.textTheme.titleLarge!.color),
                        ),
                      ),
                    ),
                  )),
              Container(height: size.height/100),

            ],
          ),
        ),
      ),
    );
  }
}
