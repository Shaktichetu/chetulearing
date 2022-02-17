import 'package:flutter/material.dart';
import 'package:sliverappbar/sliverappbar_status.dart';
import 'basic_sliverappbar.dart';
import 'sliverappbar_with_appbar.dart';
import 'sliverappbar_with_tabbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliverAppBar Demo',
      theme: ThemeData(primarySwatch: Colors.teal, brightness: Brightness.dark),
      home: SliverAppBarWithTabBar(),
    );
  }
}
