import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/home/home_event.dart';

abstract class ProductEvent {}

class ButtonClicked extends ProductEvent {
  final String id;

  ButtonClicked({required this.id});
}
