import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/change_goal_main_screen.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:ppk/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:ppk/request_constant/list_of_goals.dart';
import 'package:ppk/request_constant/request_constant.dart';

import '../../../bloc/add_goal_model/add_goal_bloc.dart';

class GoalsByTag extends StatefulWidget {
  String tag;
  int currentIndex;

  GoalsByTag(this.tag, this.currentIndex);

  @override
  State<GoalsByTag> createState() => _GoalsByTagState();
}

class _GoalsByTagState extends State<GoalsByTag> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: size.width,
                height: size.width / 2.12,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      tagColor[tags[widget.currentIndex + 1]]!,
                      BlendMode.modulate),
                  image: AssetImage('assets/by_tag_appbar.png'),
                )),
                child: Center(
                    child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      initialPage: widget.currentIndex,
                      height: 40.0,
                      viewportFraction: 0.3,
                      onPageChanged: (index, _) {
                        setState(() {
                          widget.currentIndex = index;
                        });
                      }),
                  items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                            onTap: () {
                              print(widget.currentIndex);
                              if (i < widget.currentIndex && i != 0 ||
                                  (i == 0 && widget.currentIndex == 1) ||
                                  (i == 9 && widget.currentIndex == 0)) {
                                carouselController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear);
                                widget.currentIndex == 0
                                    ? widget.currentIndex == 9
                                    : widget.currentIndex--;
                              } else {
                                if (i > widget.currentIndex ||
                                    (widget.currentIndex == 9 && i == 0)) {
                                  carouselController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                  widget.currentIndex == 9
                                      ? widget.currentIndex == 0
                                      : widget.currentIndex++;
                                }
                              }
                            },
                            child: Center(
                                child: AnimatedContainer(
                                    height: size.height / 10,
                                    width: size.width / 3,
                                    decoration: widget.currentIndex == i
                                        ? BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(100, 50)),
                                            color:
                                                darken(tagColor[tags[i + 1]]!),
                                          )
                                        : BoxDecoration(),
                                    duration: Duration(milliseconds: 200),
                                    child: Center(
                                        child: Text(
                                      tags[i + 1] as String,
                                      style: widget.currentIndex == 5 ||
                                              widget.currentIndex == 7 ||
                                              widget.currentIndex == 2 ||
                                              widget.currentIndex == 4 ||
                                              widget.currentIndex == 8||
                                          widget.currentIndex == 6||
                                          widget.currentIndex == 1
                                          ? theme.textTheme.bodySmall!.copyWith(
                                              color: theme.backgroundColor)
                                          : theme.textTheme.bodySmall,
                                      maxLines: 2,
                                    )))));
                      },
                    );
                  }).toList(),
                ))),
          ),
          Positioned(
              top: size.height / 5,
              child: Container(
                height: size.height * 4 / 5,
                width: size.width,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: goalsList[tags[widget.currentIndex + 1]]!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (contenxt, animation, secondaryAnimation) {
                              // Navigate to the SecondScreen
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => AddGoalBloc()
                                      ..add(Update(GlobalGoalModel(
                                          goalId: -1,
                                          goalTags: [
                                            tags[widget.currentIndex + 1]!
                                                as String
                                          ],
                                          name: goalsList[tags[
                                              widget.currentIndex + 1]]![index],
                                          text: '',
                                          date: DateTime.now(),
                                          subGoals: [],
                                          photos: [],
                                          private: true,
                                          mainPhoto: ''))),
                                  ),
                                  BlocProvider(
                                    create: (context) => CalendarBloc(),
                                  ),
                                ],
                                child: ChangeGoalMainScreen(),
                              );
                              ;
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
                          padding: EdgeInsets.all(size.height / 40),
                          child: Container(
                              padding: EdgeInsets.all(size.height / 40),
                              height: size.height / 7,
                              width: size.height / 7 * 3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          tagColor[
                                              tags[widget.currentIndex + 1]]!,
                                          BlendMode.modulate),
                                      image:
                                          AssetImage('assets/example_goal.png'),
                                      fit: BoxFit.contain)),
                              child: Center(
                                child: Text(
                                  goalsList[tags[widget.currentIndex + 1]]![
                                      index],
                                  style: widget.currentIndex == 5 ||
                                          widget.currentIndex == 7 ||
                                          widget.currentIndex == 2 ||
                                          widget.currentIndex == 4 ||
                                          widget.currentIndex == 8||
                                      widget.currentIndex == 6||
                                      widget.currentIndex == 1
                                      ? theme.textTheme.bodySmall!.copyWith(
                                          color: theme.backgroundColor)
                                      : theme.textTheme.bodySmall,
                                  maxLines: 2,
                                ),
                              )),
                        ),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}

Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}
