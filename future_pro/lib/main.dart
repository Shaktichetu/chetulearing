import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//https://flutterbyexample.com/lesson/future-provider
class Person {
  Person({this.name, this.age});
  final String? name;
  int? age;
}

class Home {
  final String city = "Portland";

  Future<String> get fetchAddress {
    final address = Future.delayed(const Duration(seconds: 2), () {
      return ' 1234 North Commercial Ave.';
    });

    return address;
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Person>(create: (_) => Person(name: 'Yohan', age: 25)),
        FutureProvider<String>(
            initialData: " fetching data",
            create: (context) => Home().fetchAddress),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<Person>(
            builder: (context,Person  per, child) {
              return Column(
                children: <Widget>[
                  Text("User profile:"),
                  Text("name: ${per.name}"),
                  Text("age: ${per.age}"),
              Text("address"+ Provider.of<String>(context)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
