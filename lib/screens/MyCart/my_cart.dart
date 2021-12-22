import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/AddrsPage/addrs_list.dart';
import 'package:neosoft_training_app/screens/MyCart/DeleteCart/delete_cat_model.dart';
import 'package:neosoft_training_app/screens/MyCart/EditCart/edit_cart_model.dart';
import 'package:neosoft_training_app/screens/MyCart/MyCartBloc/my_cart_bloc.dart';
import 'package:neosoft_training_app/screens/MyCart/MyCartBloc/my_cart_event.dart';
import 'package:neosoft_training_app/screens/MyCart/MyCartBloc/my_cart_state.dart';
import 'package:neosoft_training_app/screens/MyCart/item_in_cart_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class MyCart extends StatefulWidget {
  final String accessToken;
  final String userId;
  final ItemsInCartModel? itemsInCartModel;
  const MyCart(
      {Key? key,
      required this.accessToken,
      required this.itemsInCartModel,
      required this.userId})
      : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final AuthRepository authRepo = AuthRepository();
  ItemsInCartModel? itemsInCart;
  ItemsInCartModel? itemsInCart2;
  List<Datum>? data;
  int? totalcost;

  @override
  void initState() {
    data = widget.itemsInCartModel!.data == null
        ? []
        : widget.itemsInCartModel!.data!.map((z) => z).toList();

    totalcost =
        widget.itemsInCartModel == null ? 0 : widget.itemsInCartModel!.total;
    super.initState();
    // getCartData(widget.accessToken);
    itemsInCart = widget.itemsInCartModel;
  }

  getCartData(String token) async {
    itemsInCart2 = await authRepo.getCartItems(token: token);
    setState(() {
      totalcost = itemsInCart2!.total;
    });

    return itemsInCart2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: BlocProvider(
        create: (context) =>
            MyCartBloc(authRepository: context.read<AuthRepository>()),
        child: itemsInCart!.data == null
            ? const Center(
                child: Text(
                  'No Item in Cart',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocConsumer<MyCartBloc, MyCartState>(
                      listener: (context, state) async {
                    // ! calling from auth repo object
                    itemsInCart = await getCartData(widget.accessToken);

                    setState(() {
                      totalcost = state.itemsInCartModel!.total;
                    });
                  }, builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 110.33,
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) async {
                            BlocProvider.of<MyCartBloc>(context).add(
                              DeleteFromCartPressed(widget.accessToken,
                                  "${data![index].productId}"),
                            );
                            setState(() {
                              data!.removeAt(index);
                              data = state.itemsInCartModel!.data;
                              totalcost = state.itemsInCartModel!.total;
                            });
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 90,
                                child: ListTile(
                                  // ! IMAGE___________________________>
                                  leading: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SizedBox(
                                      height: 90.0,
                                      width: 70.33,
                                      child: Image.network(
                                        data![index].product.productImages,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // ! TITLE___________________________>
                                  title: Text(
                                    // items.data[index].product.name,
                                    data![index].product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.PRIMARY_COLOR_BLACK5,
                                      fontSize: 20,
                                    ),
                                  ),
                                  // ! subtitle___________________________>
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.3, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data![index].product.productCategory,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // ! DROPDOWN BUTTON___________________________>
                                        Container(
                                          height: 30,
                                          width: 50,
                                          color: AppColors.PRIMARY_COLOR_GREY1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                  dropdownColor: AppColors
                                                      .PRIMARY_COLOR_GREY2,
                                                  value: data![index]
                                                      .quantity
                                                      .toString(),
                                                  items: const [
                                                    DropdownMenuItem<String>(
                                                      child: Text("1"),
                                                      value: "1",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("2"),
                                                      value: "2",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("3"),
                                                      value: "3",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("4"),
                                                      value: "4",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("5"),
                                                      value: "5",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("6"),
                                                      value: "6",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("7"),
                                                      value: "7",
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      child: Text("8"),
                                                      value: "8",
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    print(value);

                                                    BlocProvider.of<MyCartBloc>(
                                                            context)
                                                        .add(
                                                      EditFromCartPressed(
                                                        token:
                                                            widget.accessToken,
                                                        product_id: data![index]
                                                            .productId
                                                            .toString(),
                                                        quantity: value!,
                                                      ),
                                                    );

                                                    setState(() {
                                                      // print("in dropdown list");
                                                      value = value;
                                                      data![index].quantity =
                                                          int.parse(value!);

                                                      // data = state
                                                      //     .itemsInCartModel!.data;
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${data![index].product.cost}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.PRIMARY_COLOR_BLACK5,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ],
                          ),
                          background: Container(
                            //  color: Colors.red,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                              child: const Icon(Icons.delete),
                              backgroundColor: Colors.red,
                              onPressed: () {},
                              mini: true,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //! TOTAL BLOC------------------------>
                  Container(
                    height: 67,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: AppColors.PRIMARY_COLOR_BLACK4),
                        ),
                        Text(
                          '${totalcost ?? 0}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: AppColors.PRIMARY_COLOR_BLACK4),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  // ! ORDER BUTTON-------------->
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.PRIMARY_COLOR_RED6,
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => AddressList(
                                        userId: widget.userId,
                                        token: widget.accessToken,
                                      )))
                              .then((value) {});
                        },
                        child: const Text(
                          "ORDER NOW",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        )),
                  ),
                ],
              ),
      ),
    );
  }
}
