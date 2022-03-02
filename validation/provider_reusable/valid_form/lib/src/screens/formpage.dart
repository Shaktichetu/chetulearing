import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valid_form/src/validation/sign_up_validation.dart';
import 'package:provider/provider.dart';
import 'custom_form_field.dart';

class ProviderFormPage extends StatefulWidget {
  const ProviderFormPage({Key? key}) : super(key: key);
  @override
  _ProviderFormPageState createState() => _ProviderFormPageState();
}
class _ProviderFormPageState extends State<ProviderFormPage> {
  late FormProvider _formProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<FormProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                onChanged: _formProvider.validateName,
                errorText: _formProvider.name.error,
              ),
              CustomFormField(
                hintText: 'Email',
                onChanged: _formProvider.validateEmail,
                errorText: _formProvider.email.error,
              ),
              CustomFormField(
                hintText: 'Phone',
                onChanged: _formProvider.validatePhone,
                errorText: _formProvider.phone.error,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[0-9]"),
                  )
                ],

              ),
              CustomFormField(
                hintText: 'Password',
                onChanged: _formProvider.validatePassword,
                errorText: _formProvider.password.error,
              ),
              Consumer<FormProvider>(
                builder: (context, model, child) {
                  return ElevatedButton(
                    onPressed: () {
                      if (model.validate) {
                        print("validation successful");
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (_) => SuccessPage(),
                        //   ),
                        // );
                      }
                    },
                    child: const Text('Submit'),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}