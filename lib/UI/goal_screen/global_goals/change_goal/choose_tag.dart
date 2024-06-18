import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/notebook.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/goal_screen/train/begin_train.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/bloc/choose_tag/choose_tag_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../train/choose_begin.dart';
import '../add_goal/color_filter_generator.dart';

class ChooseTag extends StatefulWidget {
  const ChooseTag({super.key});

  @override
  State<ChooseTag> createState() => _ChooseTagState();
}

class _ChooseTagState extends State<ChooseTag> {
  int _index = 0;
  List<String> tags = [
    "Личная жизнь",
    "Спорт",
    "Карьера",
    "Путешествия",
    "Хобби",
    "Учеба",
    "Развитие",
    "Активности",
    "Здоровье",
    "Финансы",
  ];

  Future isTrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [prefs.getBool('isNotChooseTagTrain') ?? true, prefs];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return FutureBuilder(
        future: isTrain(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data[0]) {
            snapshot.data[1].setBool('isNotChooseTagTrain', false);
            return ChooseTrain(
                2, 8, 'training/add_goal/выбор тега', ChooseTag());
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ChooseTagBloc()
                  ..add(addTags(
                      BlocProvider.of<AddGoalBloc>(context).state.goalTags)),
              ),
            ],
            child: BlocBuilder<ChooseTagBloc, ChooseTagState>(
              builder: (context, state) {
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
                                    image: AssetImage(
                                        'assets/close_notebook.png'))),
                          ),
                        ),
                      )),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Выберите тег',
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.textTheme.titleLarge!.color,
                              fontSize: theme.textTheme.titleMedium!.fontSize! *
                                  1.2)),
                      Container(
                        height: size.height / 2.5,
                        width: size.width,
                        child: PageView.builder(
                          itemCount: 10,
                          controller: PageController(viewportFraction: 0.8),
                          onPageChanged: (index) =>
                              setState(() => _index = index),
                          itemBuilder: (context, index) {
                            return AnimatedPadding(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastOutSlowIn,
                              padding:
                                  EdgeInsets.all(_index == index ? 0.0 : 8.0),
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<ChooseTagBloc>(context)
                                      .add(selectTag(tags[_index]));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  elevation: 4,
                                  child: ImageFilter(
                                    hue: 0.0,
                                    brightness: state.tags.contains(tags[index])
                                        ? 0.0
                                        : -0.3,
                                    saturation: 0.0,
                                    child: Container(
                                      height: size.height / 2.5,
                                      width: size.height / 3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/${index + 1}.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(height: size.height / 50),
                      Center(
                          child: InkWell(
                        onTap: () {
                          BlocProvider.of<AddGoalBloc>(context)
                              .add(AddTag(state.tags));
                          print(BlocProvider.of<AddGoalBloc>(context).state.goalTags);
                          Navigator.of(context).pop();
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
                              color: state.buttonColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              'Выбрать',
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.textTheme.titleLarge!.color),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

Widget ImageFilter({brightness, saturation, hue, child}) {
  return ColorFiltered(
      colorFilter:
          ColorFilter.matrix(ColorFilterGenerator.brightnessAdjustMatrix(
        value: brightness,
      )),
      child: ColorFiltered(
          colorFilter:
              ColorFilter.matrix(ColorFilterGenerator.saturationAdjustMatrix(
            value: saturation,
          )),
          child: ColorFiltered(
            colorFilter:
                ColorFilter.matrix(ColorFilterGenerator.hueAdjustMatrix(
              value: hue,
            )),
            child: child,
          )));
}
