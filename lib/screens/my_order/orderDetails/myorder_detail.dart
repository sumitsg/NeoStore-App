import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:neosoft_training_app/assets/colors/app_colors.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_bloc.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_event.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_state.dart';
import 'package:neosoft_training_app/screens/my_order/orderDetails/orderdetail_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class OrderDetailPage extends StatefulWidget {
  final int orderId;
  final String token;
  const OrderDetailPage({Key? key, required this.token, required this.orderId})
      : super(key: key);

  @override
  OrderDeStatetailPage createState() => OrderDeStatetailPage();
}

// ! Get MyOrder List-------------------------------->
// Future<MyOrderDetailModel> getOrderDetail(
//     {required String token, required String orderId}) async {
//   Map<String, String> parameters = {'order_id': orderId};

//   String query = Uri(queryParameters: parameters).query;
//   const String url =
//       'http://staging.php-dev.in:8844/trainingapp/api/orderDetail';
//   final reqUrl = url + '?' + query;

//   var response =
//       await http.get(Uri.parse(reqUrl), headers: {'access_token': token});

//   if (response.statusCode == 200) {
//     var result = myOrderDetailModelFromJson(response.body);
//     print(result.data);
//     return result;
//   } else {
//     var errorRes = myOrderDetailModelFromJson(response.body);
//     throw Exception(errorRes.status);
//   }
// }

class OrderDeStatetailPage extends State<OrderDetailPage> {
  late MyOrderBloc myOrderBloc1;
  MyOrderDetailModel? orderDetailModel;
  @override
  void initState() {
    super.initState();
    myOrderBloc1 = MyOrderBloc(authRepository: AuthRepository());
    myOrderBloc1.add(GetOrderDetail(widget.token, widget.orderId));
    // getD();
  }

  // getD() async {
  //   orderDetailModel =
  //       await getOrderDetail(token: widget.token, orderId: widget.orderId);
  //   print(orderDetailModel!.data);
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => BlocProvider(
        create: (context) => myOrderBloc1,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
                children: [
                  const TextSpan(text: 'Order ID :'),
                  TextSpan(
                      text: '  ${widget.orderId}',
                      style: const TextStyle(
                          fontFamily: 'Gothem',
                          fontWeight: FontWeight.w100,
                          fontSize: 20)),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          body:
              BlocBuilder<MyOrderBloc, MyOrderState>(builder: (context, state) {
            return state is OrderDetailLoaded
                ? Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.detailModel.data!.orderDetails!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: ListTile(
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.PRIMARY_COLOR_GREY2,
                                ),
                                height: 50,
                                width: 80,
                                child: Image.network(
                                  state.detailModel.data!.orderDetails![index]
                                      .prodImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                state.detailModel.data!.orderDetails![index]
                                    .prodName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.PRIMARY_COLOR_BLACK5),
                              ),
                              subtitle: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "(${state.detailModel.data!.orderDetails![index].prodCatName})",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.PRIMARY_COLOR_GRAY8),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "QTY : ${state.detailModel.data!.orderDetails![index].quantity}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.PRIMARY_COLOR_BLACK1,
                                        ),
                                      ),
                                      Text(
                                        "₹  ${state.detailModel.data!.orderDetails![index].total}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100,
                                          color: AppColors.PRIMARY_COLOR_BLACK1,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          );
                        },
                      ),
                      const Divider(
                        color: AppColors.PRIMARY_COLOR_BLACK1,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TOTAL:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.PRIMARY_COLOR_BLACK3),
                            ),
                            Text(
                              "₹  ${state.detailModel.data!.cost}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.PRIMARY_COLOR_BLACK3),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.PRIMARY_COLOR_BLACK1,
                        thickness: 1,
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ),
    );
  }
}
// ! api calling success
//  add all data in fields........>