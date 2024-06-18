import 'package:flutter/material.dart';

class AnimatedRouteOne extends PageRouteBuilder {
  final Widget widget;

  AnimatedRouteOne(this.widget)
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
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
  );
}
