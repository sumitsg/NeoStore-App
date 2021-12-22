import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';
import 'package:neosoft_training_app/screens/signUp/register/reg_bloc/register_bloc.dart';
import 'package:neosoft_training_app/screens/signUp/register/reg_bloc/register_event.dart';
import 'package:neosoft_training_app/screens/signUp/register/reg_bloc/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController phone = TextEditingController();

  //!regex for emailvalidation
  String emailValid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  String passwordRegex =
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%* #=+\(\)\^?&])[A-Za-z\d$@$!%* #=+\(\)\^?&]+$";
  String phoneNumber = r"^(?:[+0]9)?[0-9]{10}$";
  String? gender;
  String? select;
  bool aggre = false;

  // late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.didChangeDependencies();
  }

  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      //  !bloc calling--->
      body: Container(
        color: AppColors.PRIMARY_COLOR_RED2,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 33.33, right: 33.33, top: 30.0, bottom: 10.0),
          child: BlocProvider(
            create: (context) =>
                RegisterBloc(authRepo: context.read<AuthRepository>()),
            child: Form(
              key: _formKey2,
              child: SingleChildScrollView(
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
                      height: 30,
                    ),
                    //! First Name Field----------->
                    FirstnameWidget(firstName: firstName),
                    // ! sized Box----------->
                    const SizedBox(
                      height: 13.33,
                    ),
                    // ! Last Name field------>
                    LastnameWidget(lastName: lastName),
                    // ! Sized Box---------->
                    const SizedBox(
                      height: 13.33,
                    ),
                    // ! Email id ---------->
                    EmailWidget(email: email, emailValid: emailValid),
                    // ! Sized Box----->
                    const SizedBox(
                      height: 13.33,
                    ),
                    // ! Password 1----------->
                    Password(pass1: pass1, passwordRegex: passwordRegex),
                    // ! Sized Box----->
                    const SizedBox(
                      height: 13.33,
                    ),
                    // ! Password 2----------->
                    ConfirmPassword(pass2: pass2, passwordRegex: passwordRegex),
                    // ! Sized Box----->
                    const SizedBox(
                      height: 23.0,
                    ),
                    // ! Gender radio Button------------>
                    Container(child: GenderMethod()),
                    // ! Sized Box----->
                    const SizedBox(
                      height: 23.0,
                    ),
                    // ! Phone Numebr--------->
                    PhoneNoWidget(phone: phone, phoneNumber: phoneNumber),
                    // ! Sized Box----->
                    const SizedBox(
                      height: 13.33,
                    ),
                    // ! Terms and Conditions ------------>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(unselectedWidgetColor: Colors.white),
                        child: Row(
                          children: [
                            Checkbox(
                              value: aggre,
                              onChanged: (value) {
                                setState(() {
                                  aggre = value ?? false;
                                });
                              },
                            ),
                            const Text.rich(
                              TextSpan(
                                  text: 'I agree the  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 5.0,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ! Sized Box----->
                    const SizedBox(
                      height: 13.33,
                    ),
                    // ! Register Button----->
                    RegisterButton(
                      fName: firstName,
                      lName: lastName,
                      email: email,
                      pass1: pass1,
                      pass2: pass2,
                      phone: phone,
                      formKey2: _formKey2,
                      gender: gender,
                      aggre: aggre,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// ? gender---------->
  // ignore: non_constant_identifier_names
  Row GenderMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Gender',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          return Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
            ),
            child: Row(
              children: [
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                    context
                        .read<RegisterBloc>()
                        .add(RegisterGenderChanged(gender: value.toString()));
                  },
                  // onChanged: (value) => context
                  //     .read<RegisterBloc>()
                  //     .add(RegisterGenderChanged(gender: value.toString())),
                  activeColor: Colors.white,
                  toggleable: true,
                ),
                const Text(
                  'Male',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      gender = value.toString();
                    });
                    context
                        .read<RegisterBloc>()
                        .add(RegisterGenderChanged(gender: value.toString()));
                  },
                  // onChanged: (value) => context
                  //     .read<RegisterBloc>()
                  //     .add(RegisterGenderChanged(gender: value.toString())),
                  activeColor: Colors.white,
                  toggleable: true,
                ),
                const Text(
                  'Female',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required this.pass1,
    required this.pass2,
    required GlobalKey<FormState> formKey2,
    required this.gender,
    required this.aggre,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
  })  : _formKey2 = formKey2,
        super(key: key);

  final TextEditingController fName;
  final TextEditingController lName;
  final TextEditingController email;
  final TextEditingController pass1;
  final TextEditingController pass2;
  final TextEditingController phone;
  final GlobalKey<FormState> _formKey2;
  final String? gender;
  final bool aggre;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          // ignore: sized_box_for_whitespace
          : Container(
              height: 49.33,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  var equal = passwordMatch(pass1.text, pass2.text);
                  if (_formKey2.currentState!.validate() &&
                      gender != null &&
                      aggre) {
                    if (equal) {
                      context.read<RegisterBloc>().add(RegisterFormSubmitted(
                            fName: fName.text,
                            lName: lName.text,
                            email: email.text,
                            password1: pass1.text,
                            password2: pass2.text,
                            phone: phone.text,
                            gender: gender,
                          ));

                      if (state.formStatus is SubmissionSuccess) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Registration Successfull...!! '),
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Email-id already exist ...!! '),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Both Passwords doesn\t match. Please Check Onces...!! '),
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill All Data First'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.67),
                  ),
                  elevation: 0.0,
                ),
                child: const Text(
                  'REGISTER',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.PRIMARY_COLOR_RED2,
                    fontSize: 20.0,
                  ),
                ),
              ),
            );
    });
  }
}

// ?First name--->
class FirstnameWidget extends StatelessWidget {
  const FirstnameWidget({
    Key? key,
    required this.firstName,
  }) : super(key: key);

  final TextEditingController firstName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: firstName,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.person,
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
          labelText: 'First Name',
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
            return 'only Alphabates allowed';
          } else {
            return null;
          }
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterFnameChanged(fName: value)),
      );
    });
  }
}

// ?Last name--->
class LastnameWidget extends StatelessWidget {
  const LastnameWidget({
    Key? key,
    required this.lastName,
  }) : super(key: key);

  final TextEditingController lastName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: lastName,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.person,
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
          labelText: 'Last Name',
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
            return 'only Alphabates allowed';
          } else {
            return null;
          }
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterLnameChanged(lName: value)),
      );
    });
  }
}

// ?email--->
class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
    required this.email,
    required this.emailValid,
  }) : super(key: key);

  final TextEditingController email;
  final String emailValid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
          controller: email,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              color: Colors.white,
            ),
            prefixIcon: Icon(
              Icons.mail,
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
            labelText: 'Email Id',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty || !RegExp(emailValid).hasMatch(value)) {
              return 'Please Provide valid Email ';
            } else {
              return null;
            }
          },
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(RegisterEmailChanged(email: value)));
    });
  }
}

// ?pass1--->
class Password extends StatelessWidget {
  const Password({
    Key? key,
    required this.pass1,
    required this.passwordRegex,
  }) : super(key: key);

  final TextEditingController pass1;
  final String passwordRegex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: pass1,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.lock,
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
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty || (value.length < 8 || value.length > 16)) {
            return 'Password should atleast 8 to 16 characters Only';
          } else if (!RegExp(passwordRegex).hasMatch(value)) {
            return 'contains at least 1 Alphabet, 1 Number and \n 1 Special Character';
          } else {
            return null;
          }
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterPasswordChanged(password1: value)),
      );
    });
  }
}

// ?pass2--->
class ConfirmPassword extends StatelessWidget {
  const ConfirmPassword({
    Key? key,
    required this.pass2,
    required this.passwordRegex,
  }) : super(key: key);

  final TextEditingController pass2;
  final String passwordRegex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: pass2,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.lock,
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
          labelText: 'Confirm Password',
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty || (value.length < 8 || value.length > 16)) {
            return 'Password should atleast 8 to 16 characters Only';
          } else if (!RegExp(passwordRegex).hasMatch(value)) {
            return 'contains at least 1 Alphabet, 1 Number and \n 1 Special Character';
          } else {
            return null;
          }
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterConfirmPasswordChanged(password2: value)),
      );
    });
  }
}

// ? Phone--->
class PhoneNoWidget extends StatelessWidget {
  const PhoneNoWidget({
    Key? key,
    required this.phone,
    required this.phoneNumber,
  }) : super(key: key);

  final TextEditingController phone;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        controller: phone,
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.phone_iphone,
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
          labelText: 'Phone Number',
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty || !RegExp(phoneNumber).hasMatch(value)) {
            return 'Only Numbers with only 10 digits';
          } else {
            return null;
          }
        },
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterPhoneChanged(phone: value)),
      );
    });
  }
}

bool passwordMatch(String p1, String p2) {
  if (p1 == p2) {
    return true;
  } else {
    return false;
  }
}
