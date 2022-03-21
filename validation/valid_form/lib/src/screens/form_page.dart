import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'custom_form_field.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State {
//This key will be used to identify the state of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                hintText: 'Name',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z]+|\s"),
                  )
                ],
                validator: (val) {
                  if (!val!.isValidName)
                    return 'Enter valid name';
                },
              ),
              CustomFormField(
                hintText: 'Email',
                validator: (val) {
                  if (!val!.isValidEmail) return 'Enter valid email';
                },
              ),
              CustomFormField(
                hintText: 'Phone',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[0-9]"),
                  )
                ],
                validator: (val) {
                  if (!val!.isValidPhone) return 'Enter valid phone';
                },
              ),
              CustomFormField(
                hintText: 'Password',
                validator: (val) {
                  if (!val!.isValidPassword) return 'Enter valid password';
                },
              ),
             ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => SuccessPage(),
                    //   ),
                    // );
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
