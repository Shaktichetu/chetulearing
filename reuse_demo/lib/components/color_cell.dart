import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reuse_demo/utils/appsettings.dart';

class ColorCell extends StatelessWidget {
  //
  ColorCell({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: color),
      child: context.watch<AppSettings>().appColor == color
          ? Icon(
              Icons.check_circle,
              color: Colors.white,
            )
          : SizedBox(),
    );
  }
}
