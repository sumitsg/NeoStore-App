import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';

class RegisterState {
  final FormSubmissionStatus formStatus;
  final String fName;
  final String lName;
  final String email;
  final String password1;
  final String password2;
  final String gender;
  final String phone;

  RegisterState({
    this.fName = '',
    this.lName = '',
    this.email = '',
    this.password1 = '',
    this.password2 = '',
    this.gender = '',
    this.phone = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copywith(
      {String? fName,
      String? lName,
      String? email,
      String? password1,
      String? password2,
      String? gender,
      String? phone,
      FormSubmissionStatus? formStatus}) {
    return RegisterState(
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      email: email ?? this.email,
      password1: password1 ?? this.password1,
      password2: password2 ?? this.password2,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
