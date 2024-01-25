import 'package:demo_google_login/api/google_sign_in_api.dart';
import 'package:demo_google_login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column( mainAxisAlignment: MainAxisAlignment.center,children: [
        const SizedBox(width: double.infinity),
        ElevatedButton(onPressed: (){
          //signIn();
          }, child: const Text("Google sign in") )
      ],),
    );
  }

//   Future signIn() async{
//    final user =  await GoogleSignInApi.login();
//   if(user == null){
//     debugPrint("user not found");
//   } else{
//        Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const LoginPage()),
//   );
// } 
}
