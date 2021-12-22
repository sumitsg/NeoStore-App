import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/products/productDetails/detail_model.dart';
import 'package:neosoft_training_app/screens/profile/edit_profile.dart';
import 'package:neosoft_training_app/screens/profile/myAccountBloc/my_acc_bloc.dart';
import 'package:neosoft_training_app/screens/profile/myAccountBloc/my_acc_event.dart';
import 'package:neosoft_training_app/screens/profile/myAccountBloc/my_acc_state.dart';
import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_password.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class MyAccount extends StatefulWidget {
  final String accesstoken;
  final ProfileDetailsModel profileDetailsModel;
  const MyAccount(
      {Key? key, required this.accesstoken, required this.profileDetailsModel})
      : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var date = TextEditingController();
  late String imgUrl;

  UserData? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = widget.profileDetailsModel.data.userData;
    setData(data!);
  }

  setData(UserData userData) {
    // UserData userData = pro!.userData;
    firstName = TextEditingController(text: userData.firstName);
    lastName = TextEditingController(text: userData.lastName);
    email = TextEditingController(text: userData.email);
    phone = TextEditingController(text: userData.phoneNo);
    date = TextEditingController(text: userData.dob ?? '01-01-1990');
    imgUrl =
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      bottomSheet: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.PRIMARY_COLOR_WHITE,
          minimumSize: const Size(double.infinity, 53),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RepositoryProvider(
                        create: (context) => AuthRepository(),
                        child: ResetPassword(
                          accesstoken: widget.accesstoken,
                        ),
                      )));
        },
        child: const Text(
          'RESET PASSWORD',
          style: TextStyle(
              color: AppColors.PRIMARY_COLOR_BLACK1,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            MyAccBloc(authRepository: (context).read<AuthRepository>()),
        child: Container(
          color: AppColors.PRIMARY_COLOR_RED2,
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: SingleChildScrollView(
              child: BlocConsumer<MyAccBloc, ProfileDetailState>(
                  listener: (context, state) {
                if (state.profileDetailsModel != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RepositoryProvider(
                        create: (context) => AuthRepository(),
                        child: EditProfile(
                          accesstoken: widget.accesstoken,
                          profileDetailModel: widget.profileDetailsModel,
                        ),
                      ),
                    ),
                  );
                }
              }, builder: (context, state) {
                // setData(state.profileDetailsModel!.data.userData);
                return Column(
                  children: [
                    // ! PROFILE PHOTO-->
                    SizedBox(
                      width: 133,
                      height: 133,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imgUrl),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // !
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          controller: firstName,
                          style: textStyleField(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // !
                        TextFormField(
                          readOnly: true,
                          controller: lastName,
                          style: textStyleField(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // !
                        TextFormField(
                          readOnly: true,
                          controller: email,
                          style: textStyleField(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // !
                        TextFormField(
                          readOnly: true,
                          controller: phone,
                          style: textStyleField(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // !
                        TextFormField(
                          readOnly: true,
                          controller: date,
                          style: textStyleField(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.cake,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<MyAccBloc>(context)
                                  .add(EditDetailPressed(widget.accesstoken));
                            },
                            child: const Text(
                              'EDIT PROFILE',
                              style: TextStyle(
                                color: AppColors.PRIMARY_COLOR_RED2,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.PRIMARY_COLOR_WHITE,
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

  TextStyle textStyleField() {
    return const TextStyle(
      color: AppColors.PRIMARY_COLOR_WHITE,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
  }
}
