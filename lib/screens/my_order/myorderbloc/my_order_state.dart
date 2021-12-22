import 'package:neosoft_training_app/screens/my_order/my_orders_model.dart';
import 'package:neosoft_training_app/screens/my_order/orderDetails/orderdetail_model.dart';

abstract class MyOrderState {}

class OrderListLoaded extends MyOrderState {
  MyOrdersListModel listModel;
  OrderListLoaded({required this.listModel});
}

class OrderDetailLoaded extends MyOrderState {
  MyOrderDetailModel detailModel;
  OrderDetailLoaded({required this.detailModel});
}

class OrderListLoading extends MyOrderState {}
