abstract class DetailEvent {}

class ButtonClicked extends DetailEvent {
  final String id;

  ButtonClicked({required this.id});
}
