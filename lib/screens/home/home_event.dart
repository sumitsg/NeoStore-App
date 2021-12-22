import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeEvent {}

class ButtonPressed extends HomeEvent {
  final String id;

  ButtonPressed({required this.id});
}

class MyAccPressed extends HomeEvent {
  final String token;
  MyAccPressed({required this.token});
}

class MyCartPressed extends HomeEvent {
  final String token;
  MyCartPressed({required this.token});
}
