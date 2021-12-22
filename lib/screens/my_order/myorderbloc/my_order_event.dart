abstract class MyOrderEvent {}

class GetOrderList extends MyOrderEvent {
  final String token;
  GetOrderList(this.token);
}

class GetOrderDetail extends MyOrderEvent {
  final String token;
  final int orderId;

  GetOrderDetail(this.token, this.orderId);
}
