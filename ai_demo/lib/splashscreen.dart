import 'package:ai_demo/home.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
       logo: Image.asset('assets/cat.png'),
       
        // Image.network(
      //     'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: const Text("cat and Dog",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loaderColor: Color(0XFFEEDA28),
      loadingText: const Text("Loading..."),
      navigator: const Home(),
      durationInSeconds: 2,
      
    );
  }
}
