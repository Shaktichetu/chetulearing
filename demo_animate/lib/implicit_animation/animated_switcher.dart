import 'package:flutter/material.dart';

class AnimatedSwtcherExample extends StatefulWidget {
  const AnimatedSwtcherExample({super.key});

  @override
  State<AnimatedSwtcherExample> createState() => _AnimatedSwtcherExampleState();
}

class _AnimatedSwtcherExampleState extends State<AnimatedSwtcherExample> {
 bool _isFirstWidgetVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Switcher Example"),
      ),
      body: Center(
          child: AnimatedSwitcher(
              switchInCurve: Curves.bounceInOut,
              switchOutCurve: Curves.decelerate,
              duration: const Duration(seconds: 1),
              child: _isFirstWidgetVisible
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isFirstWidgetVisible = !_isFirstWidgetVisible;
                        });
                      },
                      child: const Text("Login Now!"))
                  : const CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.switch_account),
          onPressed: () {
            setState(() {
              _isFirstWidgetVisible = !_isFirstWidgetVisible;
            });
          }),
    );
  }
}
