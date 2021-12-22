import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/AddrsPage/add_addrs.dart';
import 'package:neosoft_training_app/screens/AddrsPage/ordermodel/place_order_model.dart';
import 'package:neosoft_training_app/screens/MyCart/my_cart.dart';
import 'package:neosoft_training_app/screens/home/home_page.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/shared_pref/user_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressList extends StatefulWidget {
  final String token;
  final String userId;
  const AddressList({Key? key, required this.token, required this.userId})
      : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

Future<PlaceOrderModel> placeOrder(String token, String address) async {
  const String url = 'http://staging.php-dev.in:8844/trainingapp/api/order';

  var response = await http.post(Uri.parse(url), headers: {
    'access_token': token
  }, body: {
    'address': address,
  });
  if (response.statusCode == 200) {
    var result = placeOrderModelFromJson(response.body);
    return result;
  } else {
    var errorRes = placeOrderModelFromJson(response.body);

    throw Exception(errorRes.userMsg);
  }
}

class _AddressListState extends State<AddressList> {
  late SharedPreferences _pref;
  int selectedAdd = 0;
  String? userId;
  // List addr = [
  //   'The Ruby, 29-Senapati Bapat Marg, Dadar (West),29-Senapati Bapat Marg, Dadar (West)',
  //   'The Ruby, 29-Senapati Bapat Marg, Dadar (West)',
  //   'The Ruby, 29-Senapati Bapat Marg, Dadar (West)',
  //   '72066 Block Extensions',
  //   '80106 Winston Roads',
  //   'Braun Mall',
  //   '465 Rau Track',
  //   '29213 Krajcik Crossroad',
  //   'North',
  //   'Port Gretchenside',
  // ];

  List<String> address = [];

  @override
  void initState() {
    super.initState();
    getinitalData();
    // address = UserSharedPref.getAddr() ?? [];
  }

  void getinitalData() async {
    _pref = await SharedPreferences.getInstance();

    setState(() {
      address.clear();
      address.addAll(_pref.getStringList('addressList') ?? []);
      print(address);
    });
    // var x = UserSharedPref.getAddr() ?? 'ss';
    // print(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Address List',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const AddAddressPage()))
                  .then((_) {
                getinitalData();
              });
            },
          )
        ],
      ),
      body: address.isEmpty
          ? const Center(
              child: Text(
                'Please add Address First...!',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 48,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 12, 0, 10),
                      child: Text(
                        'Shipping Address',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w100,
                            color: AppColors.PRIMARY_COLOR_BLACK1),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 450,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 100,
                    itemCount: address.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (address.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Address Found',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        );
                      }
                      return ListTile(
                        leading: SizedBox(
                          width: 30,
                          child: Radio(
                            activeColor: AppColors.PRIMARY_COLOR_GREY4,
                            value: index,
                            groupValue: selectedAdd,
                            onChanged: (value) {
                              print(index);
                              setState(() {
                                selectedAdd = index;
                              });
                            },
                          ),
                        ),
                        title: SizedBox(
                          height: 110,
                          width: 310,
                          child: Card(
                            elevation: 2,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      color: AppColors.PRIMARY_COLOR_GREY2,
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () async {
                                        setState(() {
                                          // print('data removed at index $index');
                                          address.removeAt(index);
                                          _pref.setStringList(
                                              'addressList', address);
                                        });
                                        // await UserSharedPref.setAddr(address);
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 2),
                                  child: Text(
                                    address[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.PRIMARY_COLOR_BLACK5,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      primary: AppColors.PRIMARY_COLOR_RED2,
                    ),
                    onPressed: () async {
                      var res =
                          await placeOrder(widget.token, address[selectedAdd]);
                      print(res.userMsg);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Order placed successfully')));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RepositoryProvider(
                                    create: (context) => AuthRepository(),
                                    child: HomePage(
                                      userId: widget.userId,
                                      accessToken: widget.token,
                                    ),
                                  )));
                    },
                    child: const Text(
                      'PLACE ORDER',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
