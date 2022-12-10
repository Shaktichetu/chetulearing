import 'package:demo_architech/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('myBox');
  Hive.registerAdapter(BankAccountAdapter());
  box.put('bankAccount', BankAccount(currency: "\$USD", myMoney: 10000));
  //box.put('name', 'shubham');
  //String name = box.get('name');
  //print('Name: $name');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BankAccount bankAccount = box.get('bankAccount');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("${bankAccount.currency} ${bankAccount.myMoney}")),
    );
  }
}
