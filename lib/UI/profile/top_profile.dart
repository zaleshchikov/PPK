import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/bloc/profile/profile_bloc.dart';

class TopProfile extends StatelessWidget {
  const TopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    return Container(
      height: size.width * 465 / 720,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: size.width,
              height: size.width * 465 / 720,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/top_profile.png'),
                      fit: BoxFit.fitWidth)),
            ),
          ),
          Positioned(
              top: size.width / 3,
              left: size.width / 30,
              right: size.width / 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width / 20,
                  ),
                  Image(
                      height: size.height / 10,
                      width: size.height / 10,
                      image: AssetImage('assets/cat_ava.png')),
                  BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, sstate) {
    return Container(
                    height: size.height/10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width/2,
                          child: AutoSizeText(
                            maxLines: 1,
                            sstate.nickname,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium!
                                .copyWith(
                                color: theme.textTheme.bodyMedium!.color),
                          ),
                        ),
                        sstate.isMe ? Container() : InkWell(
                          onTap: (){
                            BlocProvider.of<ProfileBloc>(context).add(Subscribe(sstate.id));
                          },
                          child: Container(
                            width: size.width / 3,
                            height: size.height / 20,
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
                                color: theme.backgroundColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                sstate.isSubsribed ? 'Отписаться' : 'Подписаться',
                                style: theme.textTheme.labelSmall
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
  },
),
                  Container(
                    width: size.width / 20,
                  ),
                ],
              )),
          Positioned(
              top: size.width / 8,
              left: size.width / 30,
              right: size.width / 30,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width / 40,
                  ),
                  // Image(
                  //     height: size.height/18,
                  //     width: size.height/18,
                  //     image: AssetImage('assets/drawer_icon.png')),
                  Container(
                    width: size.width / 1.7,
                  ),
                  // Image(
                  //     height: size.height/18,
                  //     width: size.height/18,
                  //     image: AssetImage('assets/edit_profile.png')),
                  Container(
                    width: size.width / 40,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
