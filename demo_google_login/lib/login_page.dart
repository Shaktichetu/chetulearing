import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/google_sign_in_api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future googleSignIn() async {
    try {
      final user = await GoogleSignInService.login();
       GoogleSignInAuthentication? googleKey =  await user?.authentication;
      //  Map<String, dynamic> decodedToken = JwtDecoder.decode(googleKey!.idToken!);

      log(user!.displayName.toString());
      log(user.email);
      log(user.id);
      log(user.photoUrl.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Column(
          children: [
            Text(
                "Name: ${user.displayName}\nEmail: ${user.email}\nId: ${user.id}\nPhotoUrl: ${user.photoUrl}"),
            Image.network(user.photoUrl.toString()),
          ],
        )));
      }
    } catch (exception) {
      log(exception.toString());
    }
  }

  Future googleSignOut() async {
    try {
      await GoogleSignInService.logout();
      log('Sign Out Success');
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign Out Success')));
      }
    } catch (exception) {
      log(exception.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign Out Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In Without Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: googleSignIn,
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: googleSignOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
