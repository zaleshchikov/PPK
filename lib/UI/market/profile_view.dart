import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppk/UI/market/profile_model.dart';

import '../../bloc/comments/comment_model.dart';

class ProfileView extends StatelessWidget {
  ProfileModel profile;
  ProfileView(this.profile);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    List<String> catcoins = [

    ];

    if(profile.hasCatcoinKolya){
      catcoins.add('assets/kkolya.png');
    }
    if(profile.hasCatcoinKsusha){
      catcoins.add('assets/kksusha.png');
    }    if(profile.hasCatcoinLera){
      catcoins.add('assets/klera.png');
    }    if(profile.hasCatcoinSasha){
      catcoins.add('assets/ksasha.png');
    }    if(profile.hasCatcoinVlad){
      catcoins.add('assets/kvlad.png');
    }

    return Container(
      padding: EdgeInsets.all(size.height/50),
      height: size.height/10,
      width: size.width*0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height/15,
                width: size.height/15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffDDD2C7)
                ),
              ),
              Container(width: size.width/20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width*0.2,
                    child: Text(
                        maxLines: 2,
                        profile.name, style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.textTheme.bodyMedium!.color
                    )),
                  ),

                ],
              ),
              Container(
                height: size.height/10,
                width: size.width*0.35,
                child: Stack(
                  children: 
                  catcoins.map((e) => Positioned(
                    left: size.width*0.25 - size.width*0.3*(catcoins.indexOf(e))/5,
                    top: size.height/100,
                    bottom: size.height/100,
                    child: Image(image: AssetImage(
                        e
                    ), height: size.height/20, width: size.height/20,
                    ),
                  )).toList()
                  // [
                  //   Positioned(
                  //     left: size.width*0.25,
                  //     top: size.height/100,
                  //     bottom: size.height/100,
                  //     child: Image(image: AssetImage(
                  //         'assets/klera.png'
                  //     ), height: size.height/20, width: size.height/20,
                  //     ),
                  //   ),
                  //   Positioned(
                  //     left: size.width*0.25 - size.width*0.3*1/5,
                  //     top: size.height/100,
                  //     bottom: size.height/100,
                  //     child: Image(image: AssetImage(
                  //         'assets/klera.png'
                  //     ), height: size.height/20, width: size.height/20,
                  //     ),
                  //   ),
                  //   Positioned(
                  //     left: size.width*0.25 - size.width*0.3*2/5,
                  //     top: size.height/100,
                  //     bottom: size.height/100,
                  //     child: Image(image: AssetImage(
                  //         'assets/klera.png'
                  //     ), height: size.height/20, width: size.height/20,
                  //     ),
                  //   ),
                  //   Positioned(
                  //     left: size.width*0.25 - size.width*0.3*3/5,
                  //     top: size.height/100,
                  //     bottom: size.height/100,
                  //     child: Image(image: AssetImage(
                  //         'assets/klera.png'
                  //     ), height: size.height/20, width: size.height/20,
                  //     ),
                  //   ),
                  //   Positioned(
                  //     left: size.width*0.25 - size.width*0.3*4/5,
                  //     top: size.height/100,
                  //     bottom: size.height/100,
                  //     child: Image(image: AssetImage(
                  //         'assets/klera.png'
                  //     ), height: size.height/20, width: size.height/20,
                  //     ),
                  //   ),
                  // ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
