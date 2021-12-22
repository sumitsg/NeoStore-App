import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/my_order/my_orders_model.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_event.dart';
import 'package:neosoft_training_app/screens/my_order/myorderbloc/my_order_state.dart';
import 'package:neosoft_training_app/screens/my_order/orderDetails/orderdetail_model.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  AuthRepository? authRepository;

  MyOrderBloc({this.authRepository}) : super(OrderListLoading());

  @override
  Stream<MyOrderState> mapEventToState(MyOrderEvent event) async* {
    if (event is GetOrderList) {
      try {
        MyOrdersListModel listModel =
            await authRepository!.getMyorderList(token: event.token);
        if (listModel.status == 200) {
          yield OrderListLoaded(listModel: listModel);
        }
      } on Exception catch (e) {}
    }

    if (event is GetOrderDetail) {
      try {
        MyOrderDetailModel? orderDetailModel = await authRepository!
            .getOrderDetail(token: event.token, orderId: event.orderId);
        if (orderDetailModel.status == 200) {
          yield OrderDetailLoaded(detailModel: orderDetailModel);
        }
      } on Exception catch (e) {}
    }
  }
}
