import 'package:flutter/material.dart';


class AnimatedTextSize extends StatefulWidget {
  const AnimatedTextSize({super.key});

  @override
  State<AnimatedTextSize> createState() => _AnimatedTextSizeState();
}

class _AnimatedTextSizeState extends State<AnimatedTextSize> {
  double _fontSize = 30.0;
  Color _color = Colors.grey;

  _doAnimation() {
    setState(() {
      _fontSize = 50.0;
      _color = Colors.orange;
    });
  }

  _resetAnimation() {
    setState(() {
      _fontSize = 30.0;
      _color = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Default TextStyle Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
              style: TextStyle(fontSize: _fontSize, color: _color),
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceOut,
              child: const Text("Hello Every One")),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: _doAnimation, icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: _resetAnimation, icon: const Icon(Icons.remove))
            ],
          )
        ],
      ),
    );
  }
}
