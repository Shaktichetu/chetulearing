import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reuse_demo/components/btn.dart';
import 'package:reuse_demo/components/link_btn.dart';
import 'package:reuse_demo/components/tf.dart';
import 'package:reuse_demo/utils/appsettings.dart';
import 'package:reuse_demo/utils/utils.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  //
  static const ROUTE_ID = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        backgroundColor: context.watch<AppSettings>().appColor,
      ),
      body: Container(
        child: Column(
          children: [
            AppTextFormField(
              controller: _emailController,
              helpText: 'Email',
              hintText: 'Email',
              prefixIcon: Icons.email, borderColor:Colors.blueGrey ,
            ),
            AppTextFormField(
              controller: _passwordController,
              helpText: 'Password',
              hintText: 'Password',
              isPassword: true,
              prefixIcon: Icons.lock_open, borderColor: Colors.blueGrey,
            ),
            Row(
              children: [
                Expanded(
                  child: Btn(
                    onPress: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                      Utils.saveLoggedIn(true);
                    },
                    text: 'LOGIN',
                    color: context.watch<AppSettings>().appColor,
                  ),
                )
              ],
            ),
            LinkBtn(
              text: 'Forgot Password?',
              color: Colors.green,
              onPress: () {
                //
              },
            )
          ],
        ),
      ),
    );
  }
}
