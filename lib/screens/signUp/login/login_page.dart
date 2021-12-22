import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/home/home_page.dart';
import 'package:neosoft_training_app/screens/profile/editProfileBloc/edit_profile_state.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/login_bloc.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/login_event.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/login_state.dart';
import 'package:neosoft_training_app/screens/signUp/forgotPassword/forgot_password.dart';
import 'package:neosoft_training_app/screens/signUp/register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();

  //!regex for emailvalidation
  String emailValid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
        ),
        child: LoginFormWigdet(
          formKey: _formKey,
          userName: userName,
          emailValid: emailValid,
          passWord: passWord,
        ),
      ),

      //! register button------------->
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 33.66),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'DON\'T HAVE AN ACCOUNT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            //! navigating to register Page----->
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepositoryProvider(
                      create: (context) => AuthRepository(),
                      child: const RegisterPage(),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(46, 46),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//! login form widget---------->
class LoginFormWigdet extends StatelessWidget {
  const LoginFormWigdet({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.userName,
    required this.emailValid,
    required this.passWord,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController userName;
  final String emailValid;
  final TextEditingController passWord;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.PRIMARY_COLOR_RED2,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //! title of login page
            const Pagetitle(),
            //! space between title and text field
            const SizedBox(
              height: 148 / 3,
            ),
            //! username ------->
            Username(userName: userName, emailValid: emailValid),
            const SizedBox(
              height: 20.0,
            ),
            //! Password----------->
            Password(passWord: passWord),
            const SizedBox(
              height: 33.33,
            ),
            //! Login button-------------->
            Loginbutton(
                formKey: _formKey, userName: userName, passWord: passWord),
            const SizedBox(
              height: 21.67,
            ),
            //! Forget password Text------------->
            TextButton(
              child: const Text(
                'Forgot Password ?',
                style: TextStyle(
                  color: AppColors.PRIMARY_COLOR_WHITE,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()),
                );
                print("forgot password");
              },
            ),
          ],
        ),
      ),
    );
  }
}

//! Login button-------------->
class Loginbutton extends StatelessWidget {
  Loginbutton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.userName,
    required this.passWord,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController userName;
  final TextEditingController passWord;
  final authrepo = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state.formStatus is SubmissionFailed) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email or password is wrong. try again ...!! '),
        ));
      }
    }, builder: (context, state) {
      String token = '';
      String? userId;

      return state.formStatus is FormSubmitting
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33.33),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //! add  validate credential LOGIC after api gets added to app
                    context.read<LoginBloc>().add(LoginSubmitted(
                          username: userName.text,
                          password: passWord.text,
                        ));
                    LoginModel? loginModel = (await authrepo.createModel(
                        userName.text, passWord.text));

                    if (state.formStatus is SubmissionSuccess) {
                      token = loginModel!.data.accessToken;
                      userId = "${loginModel.data.id}";

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepositoryProvider(
                            create: (context) => AuthRepository(),
                            child: HomePage(
                              accessToken: token,
                              userId: userId,
                            ),
                          ),
                        ),
                      );
                    } else if (loginModel!.status == 500) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepositoryProvider(
                              create: (context) => AuthRepository(),
                              child: const LoginPage()),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please Provide Some Data !!!')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: const Size(240, 50),
                  elevation: 0.0,
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.PRIMARY_COLOR_RED2,
                    fontSize: 26.0,
                  ),
                ),
              ),
            );
    });
  }
}

//! Password----------->
class Password extends StatelessWidget {
  const Password({
    Key? key,
    required this.passWord,
  }) : super(key: key);

  final TextEditingController passWord;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.3),
        child: TextFormField(
          controller: passWord,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
          ),
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
              fontWeight: FontWeight.w700,
              color: AppColors.PRIMARY_COLOR_WHITE,
              fontSize: 18.0,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password required..!';
            } else if (value.length < 8 || value.length > 16) {
              return 'Password should atleast 8 to 16 characters Only';
            } else {
              return null;
            }
          },
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        ),
      );
    });
  }
}

// ! username------->
class Username extends StatelessWidget {
  const Username({
    Key? key,
    required this.userName,
    required this.emailValid,
  }) : super(key: key);

  final TextEditingController userName;
  final String emailValid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.3),
        child: TextFormField(
          controller: userName,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
          ),
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
            labelText: 'Username',
            labelStyle: TextStyle(
              color: AppColors.PRIMARY_COLOR_WHITE,
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email id Required';
            } else if (!RegExp(emailValid).hasMatch(value)) {
              return 'Provide Correct email-id..!!';
            } else {
              return null;
            }
          },
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernamechanged(username: value),
              ),
        ),
      );
    });
  }
}

// ! title------->
class Pagetitle extends StatelessWidget {
  const Pagetitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'NeoSTORE',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 135 / 3,
          ),
        ),
      ),
    );
  }
}
