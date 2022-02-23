import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reuse_demo/components/color_cell.dart';
import 'package:reuse_demo/components/link_btn.dart';
import 'package:reuse_demo/utils/appsettings.dart';
import 'package:reuse_demo/utils/constants.dart';
import 'package:reuse_demo/utils/utils.dart';

import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  //
  static const ROUTE_ID = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<AppSettings>().appColor,
        title: Text('Settings'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Wrap(
              children: List<Widget>.generate(Constants.colors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    context.read<AppSettings>().updateColor(index);
                    Utils.saveThemeIndex(index);
                  },
                  child: ColorCell(
                    color: Constants.colors[index],
                  ),
                );
              }),
            ),
            LinkBtn(
              text: 'Logout',
              onPress: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.ROUTE_ID, (route) => false);
                Utils.saveLoggedIn(false);
                Utils.saveThemeIndex(0);
                context.read<AppSettings>().updateColor(0);
              },
            )
          ],
        ),
      ),
    );
  }
}
