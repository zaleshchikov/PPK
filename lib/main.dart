import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppk/UI/auth/login.dart';
import 'package:ppk/UI/auth/reset_password.dart';
import 'package:ppk/UI/auth/sign_up.dart';
import 'package:ppk/UI/auth/success_reset.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/add_date.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/choose_tag.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/goal_photo.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/goal_status.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/notebook.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/subgoal.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/change_goal_main_screen.dart';
import 'package:ppk/UI/goal_screen/top_part/main_goal_screen.dart';
import 'package:ppk/UI/goal_screen/train/begin_train.dart';
import 'package:ppk/UI/goal_screen/train/choose_begin.dart';
import 'package:ppk/UI/in_news_world/goal_list/goals_by_tag.dart';
import 'package:ppk/UI/in_news_world/goal_list/welcome_goal_list.dart';
import 'package:ppk/UI/in_news_world/news_world_main_screen.dart';
import 'package:ppk/UI/market/article_screen.dart';
import 'package:ppk/UI/market/market_screen.dart';
import 'package:ppk/UI/menu/main_menu.dart';
import 'package:ppk/UI/navigation/bottom_navigation.dart';
import 'package:ppk/UI/profile/profile.dart';
import 'package:ppk/UI/welcome/welcome_screen.dart';
import 'package:ppk/db/daily_task_db/daily_task_db.dart';
import 'package:ppk/db/user_db/user_model.dart';
import 'package:sqflite/sqlite_api.dart';

import 'db/user_db/user_db.dart';

class AdaptiveTextSize {
  const AdaptiveTextSize();
  getadaptiveTextSize(BuildContext context, dynamic value) {
    return (value / 1300) * MediaQuery.of(context).size.height;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget startWidget = MainMenu();
  if(await DatabaseUser.isFirstTimeInApp()){
    startWidget = WelcomeScreen();
  }
  initializeDateFormatting('ru_RU', null);
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {

  Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        focusColor: Color(0x33afafaf),
        bottomAppBarColor: Color(0xffE6DBD0),
        hintColor: Color(0xffF7D78D),
        canvasColor: Color(0xffECA66A),
        dividerColor: Color(0xff72646B),
        dialogBackgroundColor: Color(0xffECA66A),
        hoverColor: Color(0xffBAAEA5),
        highlightColor: Color(0xffFBD784),
        cardColor: Color(0xff9C8E87),
        indicatorColor: Color(0xff292D32),
        primaryColor: Color(0xff453643),
        errorColor: Color(0xffF26C43),
        backgroundColor: Color(0xfffef4e8),
        useMaterial3: true,
        textTheme: TextTheme(
          titleSmall: GoogleFonts.mPlusRounded1c().copyWith(
            fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 60),
            color: Color(0xff453643),
            fontWeight: FontWeight.w900
        ),
          titleLarge: GoogleFonts.mPlusRounded1c().copyWith(
            fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 48),
            color: Color(0xff453643),
            fontWeight: FontWeight.w900
          ),
          bodyLarge: GoogleFonts.mPlusRounded1c().copyWith(
              fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25),
              color: Color(0xff7C808D),fontWeight: FontWeight.w600
          ),
          titleMedium: GoogleFonts.mPlusRounded1c().copyWith(
              fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 35),
              color: Color(0xfffef4e8),
            fontWeight: FontWeight.w900
          ),
          bodyMedium: GoogleFonts.mPlusRounded1c().copyWith(
              fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 30),

              color: Color(0xff453643),
            fontWeight: FontWeight.w500
          ),
          bodySmall:GoogleFonts.mPlusRounded1c().copyWith(
              fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 23),
              color: Color(0xab73666c),
              fontWeight: FontWeight.w600
          ),
          labelSmall: GoogleFonts.mPlusRounded1c().copyWith(
            fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20),
            color: Color(0xab73666c),
            fontWeight: FontWeight.w600
        ),
        )
      ),
      home: startWidget,
    );
  }
}

