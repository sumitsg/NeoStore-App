import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/profile/editProfileBloc/edit_profile_bloc.dart';
import 'package:neosoft_training_app/screens/profile/editProfileBloc/edit_profile_event.dart';
import 'package:neosoft_training_app/screens/profile/editProfileBloc/edit_profile_state.dart';
import 'package:neosoft_training_app/screens/profile/my_account.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/profile_edited_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class EditProfile extends StatefulWidget {
  final String accesstoken;
  final ProfileDetailsModel profileDetailModel;
  const EditProfile(
      {Key? key, required this.accesstoken, required this.profileDetailModel})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var dateOfBirth = TextEditingController();

  DateTime? date;
  String emailValid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  String phoneRegex = r"(^(?:[+0]9)?[0-9]{10}$)";
  String dobValidator =
      r"^(((((0[1-9])|(1\d)|(2[0-8]))-((0[1-9])|(1[0-2])))|((31-((0[13578])|(1[02])))|((29|30)-((0[1,3-9])|(1[0-2])))))-((20[0-9][0-9]))|(29-02-20(([02468][048])|([13579][26]))))$";

  String img =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            EditProfileBloc(authRepository: (context).read<AuthRepository>()),
        child: Container(
          color: AppColors.PRIMARY_COLOR_RED2,
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: SingleChildScrollView(
              child: BlocConsumer<EditProfileBloc, EditProfileState>(
                  listener: (context, state) {
                if (state.profileDetailsModel != null) {
                  print('in listern');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RepositoryProvider(
                        create: (context) => AuthRepository(),
                        child: MyAccount(
                          accesstoken: widget.accesstoken,
                          profileDetailsModel: state.profileDetailsModel!,
                        ),
                      ),
                    ),
                  );
                }
              }, builder: (context, state) {
                return Column(
                  children: [
                    // ! PROFILE PHOTO-->
                    SizedBox(
                      width: 133,
                      height: 133,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(img),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ! FORM----->
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // ! First Name---->
                            TextFormField(
                              controller: firstName,
                              cursorColor: Colors.white,
                              style: textStyleField(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'First Name Required';
                                } else if (RegExp(r"^[a-zA-Z]+$/")
                                    .hasMatch(value)) {
                                  return 'Provide Valid Name';
                                }
                                return null;
                              },
                              decoration:
                                  textFieldDecor('First Name', Icons.person),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            // ! Last NAme---->
                            TextFormField(
                              controller: lastName,
                              cursorColor: Colors.white,
                              style: textStyleField(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Last Name Required';
                                } else if (RegExp(r"^[a-zA-Z]+$/")
                                    .hasMatch(value)) {
                                  return 'Provide Valid Name';
                                }
                                return null;
                              },
                              decoration:
                                  textFieldDecor('Last Name', Icons.person),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // ! EMAIL---->
                            TextFormField(
                              controller: email,
                              cursorColor: Colors.white,
                              style: textStyleField(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email Required';
                                } else if (!RegExp(emailValid)
                                    .hasMatch(value)) {
                                  return 'Provide Valid email';
                                }
                                return null;
                              },
                              decoration:
                                  textFieldDecor('email', Icons.email_outlined),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // ! PHONE---->
                            TextFormField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: textStyleField(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Number Required';
                                } else if (value.length < 10 &&
                                    value.length > 10) {
                                  return 'Provide Valid Phone number';
                                }
                                return null;
                              },
                              decoration:
                                  textFieldDecor('Phone', Icons.phone_android),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // ! DOB---->
                            TextFormField(
                              controller: dateOfBirth,
                              decoration: textFieldDecor('DOB', Icons.cake),
                              style: textStyleField(),
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Provide DOB';
                                } else if (!RegExp(dobValidator)
                                        .hasMatch(value) &&
                                    value.length != 10) {
                                  return 'Provide DOB In DD-MM-YYYY format';
                                }

                                print(value);
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<EditProfileBloc>(context)
                                        .add(SubmitDetailButtonPressed(
                                            widget.accesstoken,
                                            firstName.text,
                                            lastName.text,
                                            email.text,
                                            dateOfBirth.text,
                                            phone.text,
                                            img));

                                    // Navigator.pop(context, true);

                                  } else {
                                    print('please Data provide');
                                  }
                                },
                                child: const Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    color: AppColors.PRIMARY_COLOR_RED2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.PRIMARY_COLOR_WHITE,
                                  fixedSize: const Size(double.infinity, 40),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

// ! input Decoration ------>
  InputDecoration textFieldDecor(String lable, IconData icon) {
    return InputDecoration(
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      errorStyle: const TextStyle(
        color: Colors.white,
      ),
      labelText: lable,
      labelStyle: const TextStyle(
        color: AppColors.PRIMARY_COLOR_WHITE,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.PRIMARY_COLOR_WHITE,
        ),
      ),
    );
  }

  TextStyle textStyleField() {
    return const TextStyle(
      color: AppColors.PRIMARY_COLOR_WHITE,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
  }
}
