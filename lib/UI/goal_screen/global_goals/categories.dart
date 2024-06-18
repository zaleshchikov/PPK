import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final List<String> titles = [
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    List colors = [theme.highlightColor, theme.primaryColor, theme.canvasColor];

    return Container(
      width: double.infinity,
      height: size.width / 2.9,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.all(size.width / 50),
            child: Container(
                height: size.width / 3,
                width: size.width / 3,
                decoration: BoxDecoration(
                    color: colors[i % 3],
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(height: size.width / 12),
                    Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Center(
                            child: AutoSizeText(
                                maxLines: 1,
                                titles[i],
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    color: i % 3 == 1
                                        ? theme.backgroundColor
                                        : theme.primaryColor,
                                    fontWeight: FontWeight.w900)))),

                    Container(height: size.height / 100),

                    Container(height: size.width / 30),
                  ],
                )),
          );
        },
      ),
    );
  }
}
