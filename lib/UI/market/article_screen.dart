import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppk/UI/market/article_view.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF8EEE2),
      body: Stack(
        children: [
          Container(
            height: size.height - size.height / 14,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(height: size.height/100),
                Container(
                  height: size.height / 6,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Котомаркет',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Container(
                            width: size.width / 2.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              'выполняйте задания, зарабатывайте котокоины, читайте статьи и узнавайте новую информацию',
                              style: theme.textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.height / 6,
                        width: size.height / 6,
                        child: Image(
                          image: AssetImage('assets/cat_with_fish.png'),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: size.height/1.7,
                  child: GridView.builder(
                    padding: EdgeInsets.all(size.height/100),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10, mainAxisSpacing: 20,
                        childAspectRatio: 169/230,
                          crossAxisCount: 2,),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return
                          index > -1 ? ArticleView.Locked('assets/art_img.png',
                            '10 шагов к победе над прокрастинацией', '5 минут') : ArticleView('assets/art_img.png',
                              '10 шагов к победе над прокрастинацией', '5 минут');
                      }),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: theme.bottomAppBarColor,
                borderRadius: BorderRadius.circular(1000),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffb9b2ad),
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 5  horizontally
                      5.0, // Move to bottom 5 Vertically
                    ),
                  )
                ],
              ),
              height: size.height / 14,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  height: size.height / 12,
                  color: theme.bottomAppBarColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Количество Ваших\nкотокоинов:',
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                      Center(
                          child:
                              Text('0', style: theme.textTheme.bodyMedium)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
