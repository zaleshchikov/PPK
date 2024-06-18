import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppk/UI/in_news_world/articles_list.dart';
import 'package:ppk/UI/in_news_world/goal_list/welcome_goal_list.dart';
import 'package:ppk/UI/in_news_world/search_goals.dart';
import 'package:ppk/UI/in_news_world/search_users.dart';
import 'package:ppk/UI/in_news_world/users_goals.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:ppk/bloc/news_world/news_world_bloc.dart';
import 'package:ppk/bloc/search_goals_bloc/search_goals_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/search_users_bloc/search_bloc.dart';
import '../../routing_animation/animation_one.dart';
import '../goal_screen/train/begin_train.dart';
import '../goal_screen/train/choose_begin.dart';
import '../navigation/bottom_navigation.dart';
import '../profile/profile.dart';
import 'goal_list/goals_list_choose_tag.dart';

class NewsWorld extends StatelessWidget {
  
  var random = Random();
  
  String articleCard(int i){
    switch(i){
      case 0:
        return 'assets/лера.png';
      case 1:
        return 'assets/влад.png';
      case 2:
        return 'assets/ксюша.png';
      case 3:
        return 'assets/саша.png';
      case 4:
        return 'assets/коля.png';
    }
    return 'assets/лера.png';;
  }
  
  final form = FormGroup({
    'search': FormControl<String>(),
  });
  Future isTrain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [prefs.getBool('isNotNewsTrain') ?? true, prefs];
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    WidgetsBinding.instance
        .addPostFrameCallback(
            (_) async {
          var snapshot = await isTrain();
          if (snapshot[0]) {
            snapshot[1].setBool('isNotNewsTrain', false);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => ChooseTrain(2, 7, 'training/news/новости',
                    BottomNavigationScreen(NewsWorld())),
                transitionDuration: Duration(milliseconds: 400),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
          }
        }
    );
    var art = random.nextInt(5);
    return BlocProvider(
  create: (context) => NewsWorldBloc()..add(UpdateGoals()),
  child: Builder(
    builder: (context) {
      return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: size.height/10, left: size.width/15, right: size.width/15),
              height: size.height * 2,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/news_paper_.png'), fit: BoxFit.fill)),
              child: Column(
                children: [
                  Container(height: size.height/12),
                  Container(
                    height: size.height/20,
                    width: size.width*0.9,
                    child: ReactiveForm(formGroup: this.form, child: ReactiveTextField(
                      readOnly: true,
                      onChanged: (_){
                      },
                      onTap: (_){
                        Navigator.of(context).push(
                            PageTransition(
                                type: PageTransitionType.fade, child:  BlocProvider(
                              create: (context) => SearchGoalsBloc()..add(SearchGoals('%')),
                              child: SearchGoalsScreen(),
                            ), ));
                        },
                      cursorColor: Color(0x80292d32),
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          margin: EdgeInsets.only(right: 20, left: 20),
                          child: ImageIcon(
                            size: size.height/30,
                            AssetImage('assets/search.png')
                          ),
                        ),
                          hintText: 'найдите цели...',
                          hintStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          filled: true,
                          fillColor: theme.focusColor),
                      formControlName: 'search',
                    ))),
                      Container(height: size.height/30),
                      Container(
                        padding: EdgeInsets.zero,
                        height: size.width / 1.2,
                        width: size.width / 1.2,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return
                                SizedBox(
                                    height: size.width / 2.5,
                                    width: size.width / 2.5,
                                    child: Center(
                                      child: Image.asset(
                                          height: size.width / 2.5,
                                          width: size.width / 2.5,
                                          'assets/n${index+1}.png'),
                                    ));
                            })),
                  Container(height: size.height/30),
                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(AnimatedRouteOne(WelcomeGoalList()));
                     },
                    child: Container(
                      height: size.width*0.4,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/all_goals_button.png'
                          ), fit: BoxFit.fill
                        )
                      ),
                    ),
                  ),
                  Container(height: size.height/30),
                  Center(
                    child: Container(
                      height: size.width*0.4,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  articleCard(art)
                              ), fit: BoxFit.fill
                          )
                      ),
                      child: Container(
                        padding:
                        art > 2 ?
                        EdgeInsets.only(
                          left: size.width/4
                        ) : EdgeInsets.only(
                            right: size.width/4
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(height: size.height/100),
                            Container(
                              height: size.height/10,
                              width: size.width*0.4,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  articles[random.nextInt(100)], style: theme.textTheme.labelSmall,),
                            ),
                            Container(
                              height: size.height/30,
                              width: size.width*0.4,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'Грузинская пословица', style: theme.textTheme.labelSmall!.copyWith(color: theme.textTheme.bodyMedium!.color)),
                            ),],
                        ),
                      ),
                    ),
                  ),
                  Container(height: size.height/30),
                  Center(
                    child: Row(
                      children: [
                        Container(
                          height: size.height / 8,
                          width: size.width*0.7,
                          child: Text(
                              'Цели других\nпользователей',
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.textTheme.titleLarge!.color)),
                        ),
                      ],
                    ),
                  ),
                   BlocBuilder<NewsWorldBloc, NewsWorldState>(
      builder: (context, state) {
        return UsersGoals(state.goals);
      },
      )
                ],
              ),
            ),
          ),
        );
    }
  ),
);
  }
}
