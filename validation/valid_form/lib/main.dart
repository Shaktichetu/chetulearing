import 'package:flutter/material.dart';
import 'package:valid_form/src/screens/form_page.dart';

//https://blog.logrocket.com/flutter-form-validation-complete-guide/#getting-started-form-validation-flutter


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormPage(),
    );
  }
}