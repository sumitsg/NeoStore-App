import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';

abstract class LoginEvent {}

class LoginUsernamechanged extends LoginEvent {
  final String username;

  LoginUsernamechanged({required this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {
  FormSubmissionStatus? formSubmissionStatus;
  String? username;
  String? password;
  LoginSubmitted({this.formSubmissionStatus, this.username, this.password});
}
