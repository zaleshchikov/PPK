import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppk/UI/in_news_world/search_users.dart';
import 'package:ppk/UI/market/article_screen.dart';
import 'package:ppk/UI/market/profile_model.dart';
import 'package:ppk/UI/market/profile_view.dart';
import 'package:ppk/bloc/search_users_bloc/search_bloc.dart';
import 'package:ppk/routing_animation/animation_one.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final form = FormGroup({
      'search': FormControl<String>(),
    });
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/market_back.png'
          ), fit: BoxFit.cover
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(height: size.height/50),
          Container(
              height: size.height/20,
              width: size.width*0.9,
              child: ReactiveForm(formGroup: form, child: ReactiveTextField(
                readOnly: true,
                onTap: (_){
                  Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.fade, child:  BlocProvider(
                        create: (context) => SearchBloc()..add(SearchPatternEvent('%')),
                        child: SearchUsersScreen(),
                      ), ));
                },
                onChanged: (_){
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
                    hintText: 'найдите пользователей...',
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
          InkWell(
            onTap: (){
              Navigator.of(context).push(AnimatedRouteOne(ArticleScreen()));
            },
            child: Container(
              width: size.height/5/207*355,
              height: size.height/5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/kotomarket.png'
                      ), fit: BoxFit.fitHeight
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: size.height/40),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text('Котомаркет', style: theme.textTheme.bodyMedium,),
                      Text(
                        textAlign: TextAlign.center,
                        'Количество Ваших\nкотокоинов:', style: theme.textTheme.labelSmall,),
                        Container(
                          padding: EdgeInsets.all(size.height/100),
                          height: size.height/15,
                          decoration: BoxDecoration(
                            color: Color(0xffDDD2C7),
                            shape: BoxShape.circle
                          ),
                          child: Center(child: Text('0', style: theme.textTheme.bodyMedium)),
                        )
                      ]
                    ),
                  ),
                  Container(
                    width: size.height/5/207*355/2,
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(width: size.width / 20),
              Text(
                  'Подписки',
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.textTheme.titleLarge!.color)),
            ],
          ),
          Container(
            height: size.height/2.5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ProfileView(ProfileModel(id: 0, name: 'name', photo: Uint8List.fromList([]), hasCatcoinVlad: false, hasCatcoinSasha: true, hasCatcoinLera: true, hasCatcoinKsusha: true, hasCatcoinKolya: true)),
                  // ProfileView(ProfileModel(id: 0, name: 'name', photo: Uint8List.fromList([]), hasCatcoinVlad: false, hasCatcoinSasha: true, hasCatcoinLera: true, hasCatcoinKsusha: true, hasCatcoinKolya: true)),
                  // ProfileView(ProfileModel(id: 0, name: 'name', photo: Uint8List.fromList([]), hasCatcoinVlad: false, hasCatcoinSasha: true, hasCatcoinLera: true, hasCatcoinKsusha: true, hasCatcoinKolya: true)),
                  // ProfileView(ProfileModel(id: 0, name: 'name', photo: Uint8List.fromList([]), hasCatcoinVlad: false, hasCatcoinSasha: false, hasCatcoinLera: true, hasCatcoinKsusha: true, hasCatcoinKolya: true)),
                  // ProfileView(ProfileModel(id: 0, name: 'name', photo: Uint8List.fromList([]), hasCatcoinVlad: false, hasCatcoinSasha: true, hasCatcoinLera: true, hasCatcoinKsusha: true, hasCatcoinKolya: true)),
                  // ProfileView(ProfileModel(id: 0, name: 'name', photo: Uint8List.fromList([]), hasCatcoinVlad: false, hasCatcoinSasha: true, hasCatcoinLera: true, hasCatcoinKsusha: true, hasCatcoinKolya: true)),
                ],
              ),
            ),
          ),
          Container(height: size.height/50)
        ],
      ),
    );
  }
}
