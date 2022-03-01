import 'dart:convert';
import 'package:dio_allmethod/model/SpecialisationModel.dart';

import '/service/http_service.dart';
import 'package:flutter/material.dart';
import 'model/allspecialisation.dart';

void main() {
  runApp(const MyApp());
}

//https://levelup.gitconnected.com/the-best-way-to-handle-network-requests-in-flutter-874a606c07b6

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  SpecialisationModel? specialisationModel;
  HttpService httpService = HttpService();
  bool apiHit = false;
  @override
  void initState() {
    httpService.init();
    fetchProducts();
    super.initState();
  }

  void fetchProducts() async {
    final result = await httpService.request(
        url: "get_specialisations", method: Method.GET);
    if (result != null) {
      specialisationModel =
          SpecialisationModel.fromJson(json.decode(result.toString()));
      debugPrint(specialisationModel!.data![1].specialisation);
      setState(() {
        apiHit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            apiHit
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: specialisationModel!.data!.length,
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
                              specialisationModel!.data![index].specialisation!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)));
                    },
                  )
                : const Center(child: Text("fetching data"))
          ],
        ),
      ),
    );
  }
}
