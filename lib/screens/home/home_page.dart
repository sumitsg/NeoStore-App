import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';
import 'package:neosoft_training_app/screens/MyCart/my_cart.dart';
import 'package:neosoft_training_app/screens/home/home_bloc.dart';
import 'package:neosoft_training_app/screens/home/home_event.dart';
import 'package:neosoft_training_app/screens/home/home_state.dart';
import 'package:neosoft_training_app/screens/my_order/my_orders_list.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list.dart';
import 'package:neosoft_training_app/screens/products/product_list/product_list_model.dart';
import 'package:neosoft_training_app/screens/profile/my_account.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/screens/signUp/login/login_model.dart';
import 'package:neosoft_training_app/screens/signUp/login/login_page.dart';
import 'package:neosoft_training_app/screens/storeLocator/store_locator.dart';
import 'package:neosoft_training_app/shared_pref/user_shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final String accessToken;
  String? userId;
  HomePage({Key? key, required this.accessToken, this.userId})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartItemCount = 0;
  final _imagePath = [
    'sliderImages/slider_img1.jpg',
    'sliderImages/slider_img2.jpg',
    'sliderImages/slider_img3.jpg',
    'sliderImages/slider_img4.jpg'
  ];
  AuthRepository auth = AuthRepository();
  LoginModel? loginModel;
  ItemsInCartModel? myCartItem;
  String? imgPath;
  @override
  void initState() {
    loginModel = UserPreference.getUser(widget.userId!);
    imgPath = UserPreference.getProfilePicture();

    super.initState();
    getCart();
  }

  getCart() async {
    myCartItem = await auth.getCartItems(token: widget.accessToken);
    cartItemCount = myCartItem!.count;
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buildIndicator() => AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: _imagePath.length,
          effect: const SlideEffect(
            activeDotColor: Colors.grey,
            dotColor: Colors.red,
          ),
        );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'NeoSTORE',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      drawer: Drawer(
        child: BlocProvider(
          create: (context) =>
              HomeBloc(authRepository: context.read<AuthRepository>()),
          child: Container(
            color: AppColors.PRIMARY_COLOR_BLACK2,
            child: ListView(
              children: [
                // ! profile---->
                buildProfile(context),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                  setState(() {
                    cartItemCount = state.itemsInCartModel!.count;
                  });
                  if (state.itemsInCartModel != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RepositoryProvider(
                                create: (context) => AuthRepository(),
                                child: MyCart(
                                  userId: widget.userId!,
                                  accessToken: widget.accessToken,
                                  itemsInCartModel: state.itemsInCartModel!,
                                ),
                              )),
                    );
                  }
                }, builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      print(widget.accessToken);
                      print(state.itemsInCartModel);
                      context
                          .read<HomeBloc>()
                          .add(MyCartPressed(token: widget.accessToken));
                    },
                    child: myCartItemCount(
                      icon: Icons.shopping_cart_sharp,
                      text: "My Cart",
                      //? number might be fetched from api
                      number: cartItemCount,
                    ),
                  );
                }),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                // ! to call ProductList with specific category page--->
                BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    int? _id =
                        state.productListModel!.data[0].productCategoryId;

                    String _title = 'Tables';
                    switch (_id) {
                      case 1:
                        _title = "Tables";
                        break;
                      case 2:
                        _title = "Chairs";
                        break;
                      case 3:
                        _title = "Sofas";
                        break;
                      case 4:
                        _title = "Cupboards";
                        break;
                    }
                    if (state.productListModel != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepositoryProvider(
                            create: (context) => AuthRepository(),
                            child: ProductList(
                                title: _title,
                                access_token: widget.accessToken,
                                products: state.productListModel!),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        GestureDetector(
                          child: MainProductsDrawerItem(
                            icon: MdiIcons.tableChair,
                            text: 'Tables',
                            context: context,
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(ButtonPressed(id: 'Tables'));
                          },
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          child: MainProductsDrawerItem(
                            icon: MdiIcons.sofaOutline,
                            text: 'Sofas',
                            context: context,
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(ButtonPressed(id: 'Sofas'));
                          },
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          child: MainProductsDrawerItem(
                            icon: MdiIcons.chairRolling,
                            text: 'Chairs',
                            context: context,
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(ButtonPressed(id: 'Chairs'));
                          },
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          child: MainProductsDrawerItem(
                            icon: MdiIcons.cupboard,
                            text: 'Cupboards',
                            context: context,
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(ButtonPressed(id: 'Cupboards'));
                          },
                        ),
                      ],
                    );
                  },
                ),

                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                  if (state.profileDetailsModel != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RepositoryProvider(
                                  create: (context) => AuthRepository(),
                                  child: MyAccount(
                                    accesstoken: widget.accessToken,
                                    profileDetailsModel:
                                        state.profileDetailsModel!,
                                  ),
                                )));
                  }
                }, builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      print('To my account');
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MyAccount(
                      //               accesstoken: widget.accessToken,
                      //             )));
                      context
                          .read<HomeBloc>()
                          .add(MyAccPressed(token: widget.accessToken));
                    },
                    child: createBodyDrawerItem(
                        icon: Icons.person, text: 'My Account'),
                  );
                }),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StoreLocator()));
                  },
                  child: createBodyDrawerItem(
                      icon: Icons.near_me_sharp, text: 'Store Locator'),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RepositoryProvider(
                                  create: (context) => AuthRepository(),
                                  child: MyOrderList(
                                    token: widget.accessToken,
                                  ),
                                )));
                  },
                  child: createBodyDrawerItem(
                      icon: MdiIcons.orderBoolAscendingVariant,
                      text: 'My Orders'),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                // ! Logout Page-->
                GestureDetector(
                    onTap: () async {
                      await UserPreference.removeProfilePic();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RepositoryProvider(
                              create: (context) => AuthRepository(),
                              child: const LoginPage()),
                        ),
                      );
                    },
                    child: createBodyDrawerItem(
                        icon: Icons.logout, text: 'Logout')),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
              HomeBloc(authRepository: context.read<AuthRepository>()),
          child: Column(
            children: [
              // ! slider Image with indicator----->
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      reverse: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                    items: _imagePath.map((image) {
                      return Image.asset(
                        image,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      );
                    }).toList(),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: buildIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
              // ! sized box-->
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  int _id = state.productListModel!.data[0].productCategoryId;
                  print(_id);
                  String _title = 'Tables';
                  switch (_id) {
                    case 1:
                      _title = "Tables";
                      break;
                    case 2:
                      _title = "Chairs";
                      break;
                    case 3:
                      _title = "Sofas";
                      break;
                    case 4:
                      _title = "Cupboards";
                      break;
                  }
                  if (state.productListModel != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepositoryProvider(
                          create: (context) => AuthRepository(),
                          child: ProductList(
                            title: _title,
                            access_token: widget.accessToken,
                            products: state.productListModel!,
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      //! first row of buttons------>
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 13.33, right: 13.33),
                        child: Row(
                          children: [
                            // ! Table Button------->
                            GestureDetector(
                              child: Container(
                                color: AppColors.PRIMARY_COLOR_RED2,
                                height: 200,
                                width: 185,
                                padding: const EdgeInsets.all(16.67),
                                child: Column(
                                  children: [
                                    // ! Text of Table  --->
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          'Tables',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: AppColors
                                                  .PRIMARY_COLOR_WHITE),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    // ! icon of table --->
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'sliderImages/icons/dinner-table.png',
                                          alignment: Alignment.centerLeft,
                                          height: 80,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context
                                    .read<HomeBloc>()
                                    .add(ButtonPressed(id: 'Tables'));
                              },
                            ),

                            // ! space btwn first Row--->
                            const SizedBox(
                              width: 11.67,
                            ),

                            // ! Sofas Button------->
                            GestureDetector(
                              child: Container(
                                color: AppColors.PRIMARY_COLOR_RED2,
                                height: 200,
                                width: 185,
                                padding: const EdgeInsets.all(16.67),
                                child: Column(
                                  children: [
                                    // ! icon of couch --->
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'sliderImages/icons/couch.png',
                                          height: 80,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    // ! Text of sofa --->
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Sofas',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: AppColors
                                                  .PRIMARY_COLOR_WHITE),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context
                                    .read<HomeBloc>()
                                    .add(ButtonPressed(id: 'Sofas'));
                              },
                            ),
                          ],
                        ),
                      ),

                      // ! sized box-->
                      const SizedBox(
                        height: 11.66,
                      ),

                      //! Second row of buttons------>
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 13.33, right: 13.33),
                        child: Row(
                          children: [
                            // ! chair Button------->
                            GestureDetector(
                              child: Container(
                                color: AppColors.PRIMARY_COLOR_RED2,
                                height: 200,
                                width: 185,
                                padding: const EdgeInsets.all(16.67),
                                child: Column(
                                  children: [
                                    // ! text of Chair--->
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Chairs',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: AppColors
                                                  .PRIMARY_COLOR_WHITE),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),

                                    // ! icon of chair --->
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'sliderImages/icons/office-chair.png',
                                          alignment: Alignment.centerLeft,
                                          height: 80,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context
                                    .read<HomeBloc>()
                                    .add(ButtonPressed(id: 'Chairs'));
                              },
                            ),

                            // ! space btwn Second Row--->
                            const SizedBox(
                              width: 11.67,
                            ),

                            // ! cupboards Button------->
                            GestureDetector(
                              child: Container(
                                color: AppColors.PRIMARY_COLOR_RED2,
                                height: 200,
                                width: 185,
                                padding: const EdgeInsets.all(16.67),
                                child: Column(
                                  children: [
                                    // ! icon of cupboard --->
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'sliderImages/icons/cupboard.png',
                                          // alignment: Alignment.centerLeft,
                                          height: 80,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    // ! text of cupboard --->
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          'Cupboards',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: AppColors
                                                  .PRIMARY_COLOR_WHITE),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context
                                    .read<HomeBloc>()
                                    .add(ButtonPressed(id: 'Cupboards'));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return Column(
      children: [
        // !photo----->
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(imgPath == null
                  ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                  : imgPath!),
            ),
          ),
        ),
        const SizedBox(height: 18),
        // !Name------>
        Text(
          "${loginModel!.data.firstName}  ${loginModel!.data.lastName} ",
          style: const TextStyle(
              fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 13),
        // !Email Id----->
        Text(
          "${loginModel!.data.email}",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w100,
              color: AppColors.PRIMARY_COLOR_WHITE),
        ),
        const SizedBox(height: 13),
      ],
    );
  }
}

Widget createBodyDrawerItem({
  required IconData icon,
  required String text,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.PRIMARY_COLOR_WHITE,
          size: 30,
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          text,
          style: const TextStyle(
              color: AppColors.PRIMARY_COLOR_WHITE,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget myCartItemCount({
  required IconData icon,
  required String text,
  required int number,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.PRIMARY_COLOR_WHITE,
          size: 30,
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          text,
          style: const TextStyle(
              color: AppColors.PRIMARY_COLOR_WHITE,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 22,
            child: Text(
              '$number',
              style: const TextStyle(
                  color: AppColors.PRIMARY_COLOR_WHITE,
                  fontSize: 13,
                  fontWeight: FontWeight.w100),
            ),
          ),
        )
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget MainProductsDrawerItem({
  required IconData icon,
  required String text,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.PRIMARY_COLOR_WHITE,
          size: 30,
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          text,
          style: const TextStyle(
              color: AppColors.PRIMARY_COLOR_WHITE,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
