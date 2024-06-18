import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/in_news_world/articles_list.dart';
import 'package:ppk/UI/in_news_world/goal_list/welcome_goal_list.dart';
import 'package:ppk/UI/in_news_world/search_users.dart';
import 'package:ppk/UI/in_news_world/users_goals.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:ppk/bloc/news_world/news_world_bloc.dart';
import 'package:ppk/bloc/profile/profile_bloc.dart';
import 'package:ppk/bloc/search_goals_bloc/search_goals_bloc.dart';
import 'package:ppk/request_constant/request_constant.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/add_goal_model/add_goal_bloc.dart';
import '../../routing_animation/animation_one.dart';
import '../global_goal_screen/global_goal_main_screen.dart';
import '../goal_screen/train/begin_train.dart';
import '../goal_screen/train/choose_begin.dart';
import '../navigation/bottom_navigation.dart';
import '../profile/profile.dart';
import 'goal_list/goals_list_choose_tag.dart';
import 'news_world_main_screen.dart';

class SearchGoalsScreen extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocBuilder<SearchGoalsBloc, SearchGoalsState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: theme.backgroundColor,
          appBar:   AppBar(
              backgroundColor: theme.backgroundColor,
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
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: size.width/100, right: size.width/100),
              child: Column(
                children: [
                  Container(height: size.height/30),
                  Container(
                      height: size.height/20,
                      width: size.width*0.9,
                      child: ReactiveForm(

                          formGroup: this.form, child:
                      ReactiveTextField(
                        autofocus: true,
                        onChanged: (_){
                          BlocProvider.of<SearchGoalsBloc>(context).add(SearchGoals(form.control('search').value == null || form.control('search').value == '' ? '%' : form.control('search').value));
                        },
                        onTap: (_){

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
                    height: size.height/1.38,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.goals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context)
                                .push(AnimatedRouteOne(BlocProvider(
                              create: (context) =>
                              AddGoalBloc()..add(Update(state.goals[index])),
                              child: GlobalGoalMainScreen(),
                            )));},
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height/100),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: state.goals[index].goalTags.isEmpty ? theme.dividerColor : tagColor[state.goals[index].goalTags[0]]!, width: state.goals[index].goalTags.isEmpty ? 1 : 5),
                                  color: theme.backgroundColor
                                ),
                                padding: EdgeInsets.all(size.height/50),
                                width: size.width*0.9,
                                height: size.height/8,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: size.width/20,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: size.width*0.6,
                                          child: Text(
                                              maxLines: 2,
                                              state.goals[index].name, style: theme.textTheme.bodySmall!.copyWith(
                                              color: theme.dividerColor
                                          )),
                                        ),
                                        Container(
                                          width: size.width*0.75,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                child: Text(
                                                    'до ${state.goals[index].date.day} ${monthNumberToName(state.goals[index].date.month)}',
                                                    style: theme
                                                        .textTheme.labelSmall!
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  // UsersGoals([GlobalGoalModel(goalTags: ['Спорт'], name: 'name', text: 'text', date: DateTime.now(), subGoals: [], photos: [], private: false, mainPhoto: '')])
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
