import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';
import 'package:neosoft_training_app/screens/signUp/login/login_model.dart';

class LoginState {
  final String username;
  final String password;
  String? id;
  final FormSubmissionStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.id = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copywith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
    String? id,
  }) {
    return LoginState(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
