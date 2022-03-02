import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/screens/signup.dart';
import 'src/validation/signup_validation.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupValidation(),
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Signup(),
      ),
    );
  }
}