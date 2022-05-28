import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_get/formx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormObxPage(),
    );
  }
}


class FormObxPage extends StatelessWidget {
  const FormObxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormX fx = Get.put(FormX()); // controller

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation'),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                    () {
                  print('rebuild TextFormField ${fx.errorText.value}');
                  return TextFormField(
                      onChanged: fx.usernameChanged, // controller func
                      decoration: InputDecoration(
                          labelText: 'Username',
                          errorText: fx.errorText.value // obs
                      )
                  );
                },
              ),
              Obx(
                    () => ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: fx.submitFunc.value, // obs
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}