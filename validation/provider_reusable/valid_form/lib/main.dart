import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valid_form/src/validation/sign_up_validation.dart';
import 'src/screens/formpage.dart';

//https://blog.logrocket.com/flutter-form-validation-complete-guide/#getting-started-form-validation-flutter

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormProvider(),
      child: MaterialApp(
        title: 'Form Validation Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProviderFormPage(),
      ),
    );
  }
}