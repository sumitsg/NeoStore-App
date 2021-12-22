import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/signUp/forgotPassword/forgot_pass_model.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

Future<ForgotPassModel?> createModel(String email) async {
  const String url =
      'http://staging.php-dev.in:8844/trainingapp/api/users/forgot';

  final responce = await http.post(Uri.parse(url), body: {
    'email': email,
  });

  final resbody = jsonDecode(responce.body);

  if (responce.statusCode == 200) {
    final result = forgotPassModelFromJson(responce.body);

    return result;
  } else {
    return null;
  }
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //!regex for emailvalidation
  String emailValid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        color: AppColors.PRIMARY_COLOR_RED2,
        child: Padding(
          padding: const EdgeInsets.only(left: 33.33, right: 33.33, top: 60.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //! title of that Page---------->
                const Center(
                  child: Text(
                    'NeoSTORE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 135 / 3,
                    ),
                  ),
                ),
                //! sized Box---------->
                const SizedBox(
                  height: 148 / 3,
                ),
                // ! Email field--------->
                TextFormField(
                  controller: email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.PRIMARY_COLOR_WHITE,
                      ),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.PRIMARY_COLOR_WHITE,
                      fontSize: 18.0,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email Required..!';
                    } else if (!RegExp(emailValid).hasMatch(value)) {
                      return 'Provide Correct email-id..!!';
                    } else {
                      return null;
                    }
                  },
                ),
                // !sized Box--->
                const SizedBox(
                  height: 33.33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final ForgotPassModel? forgotPassModel =
                          await createModel(email.text);

                      if (forgotPassModel == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please Provide Some Valid Data !!!')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please check your Mail\'s for New Password !!!')));
                        Navigator.pop(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Provide Some Valid Data !!!')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(345, 50),
                    elevation: 0.0,
                  ),
                  child: const Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.PRIMARY_COLOR_RED2,
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
