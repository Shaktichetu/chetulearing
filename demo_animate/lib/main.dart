import 'package:demo_animate/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//
class MyApp extends StatelessWidget {
  const MyApp({super.key});//
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.orange,
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
//
class AnimationControllerStatus extends StatefulWidget {
  const AnimationControllerStatus({super.key});

  @override
  State<AnimationControllerStatus> createState() => _AnimationControllerStatusState();
}

class _AnimationControllerStatusState extends State<AnimationControllerStatus>
 with SingleTickerProviderStateMixin {
 late AnimationController _animationController;
 late Animation _animation;
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this,duration: const Duration(seconds: 2) );
    _animation = ColorTween(begin: Colors.red,end: Colors.blue).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut))..addListener(() {
       print("Animation status changed: ${_animationController.value}  ,Animation value: ${_animation.value}");
      setState(() {
    }) ;})..addStatusListener((status) {
      print("Animation status changed: $status");
    }) ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
              ElevatedButton(onPressed: (){
                _animationController.forward();
              } , child: const Icon(Icons.play_arrow) ),
              ElevatedButton(onPressed: (){
                _animationController.reverse();
              } , child: const Icon(Icons.arrow_back)),
      
      ],),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Animation controller value: ${_animationController.value}" , style: const TextStyle(fontSize: 24), ),
          Padding(padding: const EdgeInsets.all(8),
          child: Text("Animation value: ${_animation.value}" , style: TextStyle(fontSize: 24 , color: _animation.value), )),
        Container(color: _animation.value,width: 200,height: 200),
        AnimatedPadding(curve: Curves.easeInOutCirc, padding: const EdgeInsets.all(10), duration: const Duration(seconds: 1),child: const Text("Hello Maria"),)
        ],),
      ),
    );
  }
}
