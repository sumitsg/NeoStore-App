import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';

abstract class RegisterEvent {}

class RegisterFnameChanged extends RegisterEvent {
  final String fName;

  RegisterFnameChanged({required this.fName});
}

class RegisterLnameChanged extends RegisterEvent {
  final String lName;

  RegisterLnameChanged({required this.lName});
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});
}

class RegisterGenderChanged extends RegisterEvent {
  final String gender;

  RegisterGenderChanged({required this.gender});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password1;

  RegisterPasswordChanged({required this.password1});
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String password2;

  RegisterConfirmPasswordChanged({required this.password2});
}

class RegisterPhoneChanged extends RegisterEvent {
  final String phone;

  RegisterPhoneChanged({required this.phone});
}

class RegisterFormSubmitted extends RegisterEvent {
  FormSubmissionStatus? formSubmissionStatus;
  String? fName;
  String? lName;
  String? email;
  String? password1;
  String? password2;
  String? gender;
  String? phone;

  RegisterFormSubmitted({
    this.formSubmissionStatus,
    this.fName,
    this.lName,
    this.email,
    this.password1,
    this.password2,
    this.gender,
    this.phone,
  });
}
