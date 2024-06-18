import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/in_news_world/news_world_main_screen.dart';
import 'package:ppk/UI/market/market_screen.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/UI/profile/profile.dart';
import 'package:ppk/animation/animation_one.dart';
import 'package:ppk/bloc/main_menu/main_menu_bloc.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) =>
          MainMenuBloc()..add(MainMenuEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Container(
            padding:
                EdgeInsets.only(left: size.width / 25, right: size.width / 25),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/main_menu_back.png'),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height / 10,
                ),
                Row(
                  children: [
                    Text('Меню', style: theme.textTheme.titleLarge),
                  ],
                ),
                BlocBuilder<MainMenuBloc, MainMenuState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height / 1.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      AnimatedRouteOne(BottomNavigationScreen(MainGoalScreen())));
                                },
                                child: Container(
                                  height: size.width / 2.2,
                                  width: size.width / 2.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              BlocProvider.of<MainMenuBloc>(
                                                      context)
                                                  .state
                                                  .goalsPath),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      AnimatedRouteOne(BottomNavigationScreen(Profile())));
                                },
                                child: Container(
                                  height: size.width / 1.6,
                                  width: size.width / 2.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              BlocProvider.of<MainMenuBloc>(
                                                      context)
                                                  .state
                                                  .SubscriptionsPath),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height / 1.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      AnimatedRouteOne(BottomNavigationScreen(NewsWorld())));
                                },
                                child: Container(
                                  height: size.width / 1.6,
                                  width: size.width / 2.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              BlocProvider.of<MainMenuBloc>(
                                                      context)
                                                  .state
                                                  .inWorldOfGoalsPath),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      AnimatedRouteOne(BottomNavigationScreen(MarketScreen())));
                                },
                                child: Container(
                                  height: size.width / 2.2,
                                  width: size.width / 2.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              BlocProvider.of<MainMenuBloc>(
                                                      context)
                                                  .state
                                                  .coins),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                Center(
                  child: InkWell(
                    child: Container(
                      height: size.width / 4,
                      width: size.width / 4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/serch_icon.png'))),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
