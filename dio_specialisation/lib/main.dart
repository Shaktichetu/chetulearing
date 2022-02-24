import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'model/all_specialisation.dart';

void main() {
  runApp(const MyApp());
}

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

  Future<AllSpecialisation> getHttp() async {
    try {
      var response = await Dio()
          .get('https://eduarno1.herokuapp.com/get_specialisations/');
      allSpecialisation =
          AllSpecialisation.fromJson(json.decode(response.toString()));
      debugPrint(allSpecialisation!.data![1].specialisation);
      setState(() {
        apiHit = true;
      });
      return allSpecialisation!;
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
            Center(
                child: ElevatedButton(
              onPressed: () {
                getHttp();
              },
              child: Text("Get data"),
            )),
            const SizedBox(height: 20),
            apiHit
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: allSpecialisation!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                              allSpecialisation!.data![index].specialisation!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)));
                    },
                  )
                : const Text("fetching data")
          ],
        ),
      ),
    );
  }
}
