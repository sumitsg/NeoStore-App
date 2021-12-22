import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/my_order/my_orders_model.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_bloc.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_event.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_state.dart';
import 'package:neosoft_training_app/screens/my_order/orderDetails/myorder_detail.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class MyOrderList extends StatefulWidget {
  final String token;
  const MyOrderList({Key? key, required this.token}) : super(key: key);

  @override
  _MyOrderListState createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {
  late MyOrderBloc myorderbloc;

  @override
  void initState() {
    super.initState();
    myorderbloc = MyOrderBloc(authRepository: AuthRepository());
    // myorderbloc.authRepository!.getMyorderList(token: widget.token);
    myorderbloc.add(GetOrderList(widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => BlocProvider(
        create: (context) => myorderbloc,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('My Orders',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
            actions: const [Icon(Icons.search)],
          ),
          body:
              BlocBuilder<MyOrderBloc, MyOrderState>(builder: (context, state) {
            return state is OrderListLoaded
                ? ListView.separated(
                    itemCount: state.listModel.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID: - ${state.listModel.data![index].id}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.PRIMARY_COLOR_BLACK5,
                                      fontFamily: 'GOTHAM',
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Order Date: - ${state.listModel.data![index].created}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.PRIMARY_COLOR_BLACK4,
                                      fontFamily: 'GOTHAM',
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '₹ ${state.listModel.data![index].cost}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  color: AppColors.PRIMARY_COLOR_BLACK1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          int orderid = state.listModel.data![index].id;
                          // print('${state.listModel.data![index].id} is Pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailPage(
                                        token: widget.token,
                                        orderId: orderid,
                                      )));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
