import 'package:flutter/material.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/goal_screen/train/begin_train.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';

class ChooseTrain extends StatelessWidget {
  int nextScreenIndex;
  int maxIndex;
  String imagePatter;
  Widget finalWidget;
  ChooseTrain(this.nextScreenIndex, this.maxIndex, this.imagePatter, this.finalWidget);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/${imagePatter}${nextScreenIndex-1}.png'), fit: BoxFit.fill
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: size.height/2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => BeginTrain( nextScreenIndex, maxIndex, imagePatter, finalWidget, 1),
                          transitionDuration: Duration(milliseconds: 400),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width / 4,
                      height: size.width / 5,
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
                        child: Text(
                          'Да!',
                          style: theme.textTheme.titleMedium!
                              .copyWith(color: theme.textTheme.titleLarge!.color),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => finalWidget,
                          transitionDuration: Duration(milliseconds: 400),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width / 4,
                      height: size.width / 5,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: theme.dividerColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Не..',
                          style: theme.textTheme.titleMedium!
                              .copyWith(color: theme.textTheme.titleLarge!.color),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
