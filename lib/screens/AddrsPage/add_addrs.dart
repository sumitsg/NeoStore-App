import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _pref;

  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    _pref = await SharedPreferences.getInstance();
  }

  final addrController = TextEditingController();
  final landMarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();

  List<String> addrList = [];
  int count = 0;
  @override
  void dispose() {
    addrController.dispose();
    landMarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
    super.dispose();
  }

  void clear() {
    addrController.clear();
    landMarkController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
    countryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Address',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.PRIMARY_COLOR_GREY1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ADDRESS',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.PRIMARY_COLOR_BLACK1),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //! Addr text field---------------
                  Container(
                    decoration: containerDecor(),
                    child: TextFormField(
                      controller: addrController,
                      maxLines: 5,
                      style: const TextStyle(
                          fontWeight: FontWeight.w100, fontSize: 17),
                      decoration: textFieldDecoration('Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Provide Address... ';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 26,
                  ),

                  //! Landmark field---------------
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'CITY',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.PRIMARY_COLOR_BLACK1),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  //! Landmark field ---------------
                  Container(
                    decoration: containerDecor(),
                    child: TextFormField(
                      maxLines: 1,
                      controller: landMarkController,
                      style: const TextStyle(
                          fontWeight: FontWeight.w100, fontSize: 17),
                      decoration: textFieldDecoration('LANDMARK'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Provide Address... ';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //
                  //
                  //
                  // ! CITY,STATE,ZIP,COUNTY BLoc-------------->
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 240,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  ! FIRST COLUMN_____________>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // !City Text------------>
                            Text(
                              'CITY',
                              style: lableTextStyle(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // !City field------------>
                            Container(
                              width: 170,
                              height: 50,
                              decoration: containerDecor(),
                              child: TextFormField(
                                controller: cityController,
                                style: const TextStyle(
                                    color: AppColors.PRIMARY_COLOR_BLACK1,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13.33),
                                decoration: textFieldDecoration('CITY'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Provide Address... ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // !Zip Text------------>
                            Text(
                              'ZIP CODE',
                              style: lableTextStyle(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // !ZIP field------------>
                            Container(
                              width: 170,
                              height: 50,
                              decoration: containerDecor(),
                              child: TextFormField(
                                controller: zipController,
                                style: const TextStyle(
                                    color: AppColors.PRIMARY_COLOR_BLACK1,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13.33),
                                keyboardType: TextInputType.number,
                                decoration: textFieldDecoration('ZIP CODE'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Provide Address... ';
                                  } else if (value.length < 6 ||
                                      value.length > 6) {
                                    return ' zip should be 6 digit';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        // ! SECOND COLUMN___________>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // !STATe Text------------>
                            Text(
                              'STATE',
                              style: lableTextStyle(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // !STATE field------------>
                            Container(
                              width: 170,
                              height: 50,
                              decoration: containerDecor(),
                              child: TextFormField(
                                controller: stateController,
                                style: const TextStyle(
                                    color: AppColors.PRIMARY_COLOR_BLACK1,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13.33),
                                decoration: textFieldDecoration('STATE'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Provide Address... ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // !COUNTRY Text------------>
                            Text(
                              'COUNTRY',
                              style: lableTextStyle(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // ! COUNTRY field------------>
                            Container(
                              width: 170,
                              height: 50,
                              decoration: containerDecor(),
                              child: TextFormField(
                                controller: countryController,
                                style: const TextStyle(
                                    color: AppColors.PRIMARY_COLOR_BLACK1,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13.33),
                                keyboardType: TextInputType.number,
                                decoration: textFieldDecoration('COUNTRY'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Provide Address... ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: AppColors.PRIMARY_COLOR_RED2,
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var templist = _pref.getStringList('addressList') ?? [];
                        templist.add(addrController.text +
                            " " +
                            cityController.text +
                            " " +
                            zipController.text +
                            " " +
                            stateController.text);

                        print(templist);
                        _pref.setStringList('addressList', templist);
                        clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Address added Successfully')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Provide Correct Data')));
                      }
                    },
                    child: const Text(
                      'SAVE ADDRESS',
                      style: TextStyle(
                          color: AppColors.PRIMARY_COLOR_WHITE,
                          fontWeight: FontWeight.w500,
                          fontSize: 28),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration containerDecor() =>
      const BoxDecoration(color: AppColors.PRIMARY_COLOR_WHITE);

  InputDecoration textFieldDecoration(String hinttxt) {
    return InputDecoration(
      hintText: hinttxt,
      hintStyle: const TextStyle(color: AppColors.PRIMARY_COLOR_GREY3),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: const EdgeInsets.all(12),
    );
  }

  TextStyle lableTextStyle() {
    return const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.PRIMARY_COLOR_BLACK1);
  }
}
