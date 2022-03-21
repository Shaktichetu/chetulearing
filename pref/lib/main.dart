import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {

void setValues() async {
final prefs = await SharedPreferences.getInstance();
await prefs.setInt('counter', 10);
await prefs.setBool('repeat', true); 
await prefs.setDouble('decimal', 1.5); 
await prefs.setString('action', 'Start'); 
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
print('Values Set in Shared Prefs!!');  
}

  void getValues() async {
    print('Getting Values from shared Preferences');
    final prefs = await SharedPreferences.getInstance();
final int? counter = prefs.getInt('counter');
final bool? repeat = prefs.getBool('repeat');
final double? decimal = prefs.getDouble('decimal');
final String? action = prefs.getString('action');
final List<String>? items = prefs.getStringList('items');

    print('counter: ${counter}');
    print('repeat: ${repeat}');
    print('items: ${items}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shared Pref demo")),
      body: Column(
        children: <Widget>[
          Container(
            child: RaisedButton(
              child: Text('Set Values'),
              textColor: Colors.white,
              color: Colors.blueAccent,
              onPressed: () async {
                setValues();
              },
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('Get Values'),
              textColor: Colors.white,
              color: Colors.blueAccent,
              onPressed: () async {
                getValues();
              },
            ),
          ),
        ],
      ),
    );
  }
}