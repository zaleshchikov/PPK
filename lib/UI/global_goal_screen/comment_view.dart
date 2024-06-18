import 'package:flutter/material.dart';

import '../../bloc/comments/comment_model.dart';

class CommentView extends StatelessWidget {
  Comment comment;
  CommentView(this.comment);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(size.height/50),
      width: size.width*0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height/20,
            width: size.height/20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF8EEE2)
            ),
          ),
          Container(width: size.width/20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width*0.6,
                child: Text(
                  maxLines: 2,
                    comment.authorNick, style: theme.textTheme.bodySmall!.copyWith(
                    color: Color(0x99747474)
                )),
              ),
              Container(
                width: size.width*0.6,
                child: Text(
                  maxLines: 100,
                  comment.text, style: theme.textTheme.labelSmall,),
              )
            ],
          )
        ],
      ),
    );
  }
}
