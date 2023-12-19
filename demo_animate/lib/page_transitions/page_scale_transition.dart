import 'package:flutter/material.dart'; 

class PageScaleTransition extends PageRouteBuilder {
  final dynamic page;

  PageScaleTransition(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation1, secondaryAnimation, child) {
              var animation = Tween<double>(begin: 0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation1, curve: Curves.bounceInOut));

              return ScaleTransition(
                scale: animation,
                child: child,
              );
            });
}
