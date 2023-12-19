import 'package:flutter/material.dart'; 

class PageRotateTransition extends PageRouteBuilder {
  final dynamic page;

  PageRotateTransition(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation2, secondaryAnimation, child) {
              // end =1; its number of turns
              var animation = Tween<double>(begin: 0, end: 1.0).animate(
                  CurvedAnimation(parent: animation2, curve: Curves.linear));

              return RotationTransition(
                turns: animation,
                child: child,
              );
            });
}
