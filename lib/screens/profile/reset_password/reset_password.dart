import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/screens/profile/my_account.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_bloc.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_event.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_password_model.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_state.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class ResetPassword extends StatefulWidget {
  final String accesstoken;
  const ResetPassword({Key? key, required this.accesstoken}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass1 = TextEditingController();
  TextEditingController newPass2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String passwordRegex =
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%* #=+\(\)\^?&])[A-Za-z\d$@$!%* #=+\(\)\^?&]+$";

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
      body: BlocProvider(
        create: (context) =>
            ResetBloc(authRepository: (context).read<AuthRepository>()),
        child: Container(
          color: AppColors.PRIMARY_COLOR_RED2,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 33.33, right: 33.33, top: 60.0),
            child: BlocConsumer<ResetBloc, ResetPasswordState>(
                listener: (context, state) {
              if (state.profileDetailsModel != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password Reset Successfully..!'),
                  ),
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RepositoryProvider(
                      create: (context) => AuthRepository(),
                      child: MyAccount(
                          accesstoken: widget.accesstoken,
                          profileDetailsModel: state.profileDetailsModel!),
                    ),
                  ),
                );
              }
            }, builder: (context, state) {
              return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  children: [
                    Column(
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
                        //!Current Password-------->
                        TextFormField(
                          controller: currentPass,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration:
                              textfieldDecor(Icons.lock, 'Current Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password required..!';
                            } else if (value.length < 8 || value.length > 16) {
                              return 'Password should atleast 8 to 16 characters Only';
                            } else {
                              return null;
                            }
                          },
                        ),

                        //! sized Box---------->
                        const SizedBox(
                          height: 20.0,
                        ),
                        // ! New password field 1------->
                        TextFormField(
                          controller: newPass1,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration:
                              textfieldDecor(Icons.lock, 'New Password '),
                          validator: (value) {
                            if (value!.isEmpty ||
                                (value.length < 8 || value.length > 16)) {
                              return 'Password should atleast 8 to 16 characters Only';
                            } else if (!RegExp(passwordRegex).hasMatch(value)) {
                              return 'contains at least 1 Alphabet, 1 Number and \n 1 Special Character';
                            } else {
                              return null;
                            }
                          },
                        ),
                        //! sized Box---------->
                        const SizedBox(
                          height: 20.0,
                        ),
                        // ! New password field 2------->
                        TextFormField(
                          controller: newPass2,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration:
                              textfieldDecor(Icons.lock, 'Confirm Password'),
                          validator: (value) {
                            if (value!.isEmpty ||
                                (value.length < 8 || value.length > 16)) {
                              return 'Password should atleast 8 to 16 characters Only';
                            } else if (!RegExp(passwordRegex).hasMatch(value)) {
                              return 'contains at least 1 Alphabet, 1 Number and \n 1 Special Character';
                            } else {
                              return null;
                            }
                          },
                        ),
                        //! sized Box---------->
                        const SizedBox(
                          height: 20.0,
                        ),
                        // ! Reset Password Button--------->
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (newPass1.text == newPass2.text) {
                                BlocProvider.of<ResetBloc>(context).add(
                                    ResetButtonPressed(
                                        widget.accesstoken,
                                        currentPass.text,
                                        newPass1.text,
                                        newPass2.text));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'New passwords are Identical \n Please check it once !!!'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please Provide Some Data !!!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: const Size(345, 50),
                            elevation: 0.0,
                          ),
                          child: const Text(
                            'RESET PASSWORD',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.PRIMARY_COLOR_RED2,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  InputDecoration textfieldDecor(IconData icon, String lableText) {
    return InputDecoration(
      errorStyle: const TextStyle(
        color: Colors.white,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.PRIMARY_COLOR_WHITE,
        ),
      ),
      labelText: lableText,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.PRIMARY_COLOR_WHITE,
        fontSize: 18.0,
      ),
    );
  }
}
