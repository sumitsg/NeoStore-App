import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/AddrsPage/add_addrs.dart';
import 'package:neosoft_training_app/screens/AddrsPage/addrs_list.dart';
import 'package:neosoft_training_app/screens/home/home_page.dart';
import 'package:neosoft_training_app/screens/my_order/my_orders_list.dart';
import 'package:neosoft_training_app/screens/products/productDetails/product_detail.dart';
import 'package:neosoft_training_app/screens/profile/my_account.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/screens/signUp/forgotPassword/forgot_password.dart';
import 'package:neosoft_training_app/screens/signUp/register/reg_bloc/register_bloc.dart';
import 'package:neosoft_training_app/screens/signUp/register/register_page.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_password.dart';
import 'screens/signUp/login/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
        hintColor: AppColors.PRIMARY_COLOR_WHITE,
        fontFamily: 'Gotham',
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              //width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.PRIMARY_COLOR_WHITE,
              width: 1.0,
            ),
          ),
        ),
        primarySwatch: Colors.red,
        // primaryColor: AppColors.PRIMARY_COLOR_RED2,
      ),
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        // child: HomePage(
        //   accessToken: '619cfa89458d8',
        // ),
        child: const LoginPage(),
      ),
      routes: {
        '/loginScreen': (context) => const LoginPage(),
      },
    );
  }
}

// TODO------------->
// shridharghadi20@gmail.com
// asd@1234
// 61827d01a6136 token for sumit
