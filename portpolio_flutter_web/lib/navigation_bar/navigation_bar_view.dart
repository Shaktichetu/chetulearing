import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if (size.isMobile) {
          return SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(
              children: [
                const SizedBox(width: 20),
                const FlutterLogo(),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                )
              ],
            ),
          );
        }

        onPressed() => print('click');
        return Container(
          height: 100,
          width: 1507,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const FlutterLogo(),
              const Spacer(),
              for (var item in kNavigationItems)
                NavigationBarItem(onPressed: onPressed, text: item.text),
            ],
          ),
        );
      },
    );
  }
}

class NavigationItem {
  final String text;

  NavigationItem(this.text);
}

final kNavigationItems = [
  NavigationItem('Projects'),
  NavigationItem('Skills'),
  NavigationItem('About Me'),
  NavigationItem('Blog'),
];

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 650;
    return Container(
      padding: const EdgeInsets.only(left: 64),
      child: InkWell(
        onTap: onPressed,
        mouseCursor: MaterialStateMouseCursor.clickable,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSmall ? 17 : 24,
          ),
        ),
      ),
    );
  }
}
