import 'package:flutter/material.dart';

class ArticleView extends StatelessWidget {
  bool locked = false;
  String image;
  String name;
  String time;

  ArticleView(
      this.image,
      this.name,
      this.time
      );

  ArticleView.Locked(
      this.image,
      this.name,
      this.time,
      ){
    locked = true;
  }



  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height/4,
      width: size.height/4*169/230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
            color: Color(0xffDDD2C7)
      ),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
              ),
              child: Image(image: AssetImage(locked ? 'assets/locked.png' : image), fit: BoxFit.cover, width: size.height*169/230,)),
          Container(
            padding: EdgeInsets.all(size.height/50),
            child: Text(
              locked ? 'Статья закрыта' : name, style: theme.textTheme.labelSmall!.copyWith(
              color: locked ? theme.textTheme.labelSmall!.color : theme.textTheme.bodyMedium!.color
            ),
            ),
          ),
          locked ? Center(
            child: Container(
              height: size.height/30,
              width: size.height/10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xff453643)
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('200', style: theme.textTheme.labelSmall!.copyWith(color: Colors.white),),
                    Image(image: AssetImage('assets/klera.png'), height: size.height/40,width: size.height/40)
                  ],
                ),
              ),
            ),
          ) :
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('assets/time.png'), height: size.height/50),
              Container(
                child: Text(
                    time, style: theme.textTheme.labelSmall,
                ),
              ),
              Container(width: size.width/9,)
            ],
          ),
        ],
      ),
    );
  }
}
