import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/change_goal/choose_tag.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/request_constant/request_constant.dart';

class TagsList extends StatefulWidget {
  bool onlyRead = false;
  TagsList();
  TagsList.OnlyRead(){
    this.onlyRead = true;
  }

  @override
  State<TagsList> createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: size.height / 2/3*( BlocProvider.of<AddGoalBloc>(context).state.goalTags.length > 2 ? 2 : widget.onlyRead && BlocProvider.of<AddGoalBloc>(context).state.goalTags.length == 1 ? 1 : 2),
            width: size.width / 1.4,
            child: GridView.count(
              controller: _controller,
              physics: BlocProvider.of<AddGoalBloc>(context).state.goalTags.length > 4 ? ScrollPhysics():NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                ...BlocProvider.of<AddGoalBloc>(context).state.goalTags
                    .map((e) => Container(
                        height: size.width / 3,
                        width: size.width / 3,
                        child: Stack(
                          children: [
                            SizedBox(
                                height: size.width / 3,
                                width: size.width / 3,
                                child: Center(
                                  child: Image.asset(
                                      height: size.width / 3.1,
                                      width: size.width / 3.1,
                                      'assets/n' + tags[e].toString() + '.png'),
                                )),
                           widget.onlyRead ? Container() : Align(
                             alignment: Alignment.topRight,
                             child: InkWell(
                                onTap: () {
                                  if(BlocProvider.of<AddGoalBloc>(context).state.goalTags.length > 1){
                                  BlocProvider.of<AddGoalBloc>(context)
                                      .add(DeleteTag(tags[e].toString()));}
                                  print(BlocProvider.of<AddGoalBloc>(context)
                                      .state
                                      .goalTags);
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                    child: Image.asset(
                                        height: size.width / 12,
                                        width: size.width / 12,
                                        'assets/close.png')),
                              ),
                           ),
                          ],
                        )))
                    .toList(),
                widget.onlyRead ? Container() : Container(
                  height: size.width / 4,
                  width: size.width / 4,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder:
                            (contenxt, animation, secondaryAnimation) {
                          // Navigate to the SecondScreen
                          return BlocProvider.value(
                            value: BlocProvider.of<AddGoalBloc>(context),
                            child: ChooseTag(),
                          );
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
                    child: Image.asset(
                        height: size.width / 4,
                        width: size.width / 4,
                        'assets/change_tags.png'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
