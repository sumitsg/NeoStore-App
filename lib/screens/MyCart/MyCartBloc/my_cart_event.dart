abstract class MyCartEvent {}

class EditFromCartPressed extends MyCartEvent {
  final String token;
  final String product_id;
  final String quantity;

  EditFromCartPressed(
      {required this.token, required this.product_id, required this.quantity});
}

class DeleteFromCartPressed extends MyCartEvent {
  final String token;
  final String product_id;

  DeleteFromCartPressed(this.token, this.product_id);
}
