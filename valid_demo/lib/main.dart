import 'package:flutter/material.dart';
import 'package:valid_demo/mixins/valiation_mixin.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String name = '';
  final GlobalKey<FormFieldState> _nameKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _nameController,
                      key: _nameKey,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter name',
                        focusedBorder: OutlineInputBorder(
                            borderSide: _nameController.text.length >= 6
                                ? const BorderSide(color: Colors.green)
                                : const BorderSide(color: Colors.redAccent),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (String? name) {
                        if (validateName(name!)) {
                          return null;
                        } else {
                          return 'Invalid Name';
                        }
                      },
                      onChanged: (text) {
                        setState(() {
                          _nameKey.currentState!.validate();
                        });
                      },
                      onSaved: (text) {
                        name = text!;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          formKey.currentState!.reset();
                        } else {
                          Fluttertoast.showToast(
                              msg: "The name is not valid",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Text("submit"))
                ],
              )),
        ),
      ),
    );
  }
}
