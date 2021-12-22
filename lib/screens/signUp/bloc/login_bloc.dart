import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/login_event.dart';
import 'package:bloc/bloc.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/login_state.dart';
import 'package:neosoft_training_app/screens/signUp/login/login_model.dart';
import 'package:neosoft_training_app/shared_pref/user_shared_pref.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // username
    if (event is LoginUsernamechanged) {
      yield state.copywith(username: event.username);

      // password
    } else if (event is LoginPasswordChanged) {
      yield state.copywith(password: event.password);

      //formsubmitting
    } else if (event is LoginSubmitted) {
      yield state.copywith(
        formStatus: FormSubmitting(),
        username: event.username,
        password: event.password,
      );

      try {
        LoginModel? loginModel =
            await authRepo.createModel(event.username, event.password);

        if (loginModel!.status == 200) {
          await UserPreference.setUser(loginModel);
          yield state.copywith(formStatus: SubmissionSuccess());
        }
      } on Exception catch (e) {
        // print(e);
        // print("in else bloc");
        yield state.copywith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
