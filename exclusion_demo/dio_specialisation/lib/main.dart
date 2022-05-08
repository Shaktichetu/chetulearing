import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'model/all_specialisation.dart';

void main() {
  runApp(const MyApp());
}

//https://levelup.gitconnected.com/the-best-way-to-handle-network-requests-in-flutter-874a606c07b6

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllSpecialisation? allSpecialisation;
  bool apiHit = false;
  DateTime _currentDate = DateTime.now();
  final expire_date = TextEditingController();

  Future<Null> _selectedDate(BuildContext context) async {
    var today = DateTime.now();
    final DateTime? _selDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(today.year - 1),
        lastDate: DateTime(today.year + 1),
        builder: (context, child) {
          return SingleChildScrollView(child: child);
        });

    if (_selDate != null) {
      setState(() {
        _currentDate = _selDate;
        print(_currentDate.toUtc().toIso8601String());
      });
    }
  }

  getHttp() async {
    try {
      var response = await Dio().post(
          'https://swxcanary.com/users/bb315d8a-bd2c-4e5e-b3b1-3e4f1e172374/exclusions',
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
                  'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqZG9lIiwiaWF0IjoxNjUyMDM4ODE0LCJleHAiOjE2NTIxMjUyMTQsInJvbGVzIjpbeyJuYW1lIjoiQkVUVE9SIiwiYXV0aG9yaXR5IjoiUk9MRV9CRVRUT1IifV19.BDt0MnPKN4-1w0ukUGB6zQD1rgDChwHEVtjpZ7q9BXVARrFsmFSzjzJWhQS0Ay-rGdGPRbPW3MWQXYWbfi8MAg',
            },
          ),
          data: {
            "exclusionBegin": "2022-05-21T10:13:00.000Z",
            "exclusionExpiry": _currentDate.toUtc().toIso8601String()
          });

      print(response.statusCode);
      setState(() {
        apiHit = true;
      });
    } catch (e) {
      throw Exception('Something bad happened.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        margin:const EdgeInsets.all(8),
                        child:const Text("Expiry Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        _selectedDate(context);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        height: 35,
                        child: TextFormField(
                          enabled: false,
                          controller: expire_date
                            ..text = DateFormat("yyyy-MM-dd")
                                .format(_currentDate)
                                .toString(),
                          decoration:const InputDecoration(
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const  SizedBox(height: 10),
            Center(
                child: ElevatedButton(
              onPressed: () {
                getHttp();
              },
              child:const Text("Get data"),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
