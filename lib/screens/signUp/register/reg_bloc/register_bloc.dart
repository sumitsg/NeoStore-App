import 'package:flutter/src/material/elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/auth_repository.dart';
import 'package:neosoft_training_app/screens/signUp/bloc/form_status.dart';
import 'package:neosoft_training_app/screens/signUp/register/reg_bloc/register_event.dart';
import 'package:neosoft_training_app/screens/signUp/register/reg_bloc/register_state.dart';
import 'package:neosoft_training_app/screens/signUp/register/register_model.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;

  RegisterBloc({
    required this.authRepo,
  }) : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // ! fname---->
    if (event is RegisterFnameChanged) {
      yield state.copywith(fName: event.fName);
    }
    // ! lName--->
    else if (event is RegisterLnameChanged) {
      yield state.copywith(lName: event.lName);
    }
    // ! email------>
    else if (event is RegisterEmailChanged) {
      yield state.copywith(email: event.email);
    }
    // ! pass1---->
    else if (event is RegisterPasswordChanged) {
      yield state.copywith(password1: event.password1);
    }
    // !pass2-->
    else if (event is RegisterConfirmPasswordChanged) {
      yield state.copywith(password2: event.password2);
    }
    // !gender---->
    else if (event is RegisterGenderChanged) {
      yield state.copywith(gender: event.gender);
    }
    // ! phone --->
    else if (event is RegisterPhoneChanged) {
      yield state.copywith(phone: event.phone);
    } //! register Form Submitting--->
    else if (event is RegisterFormSubmitted) {
      yield state.copywith(
        formStatus: FormSubmitting(),
        fName: event.fName,
        lName: event.lName,
        email: event.email,
        password1: event.password1,
        password2: event.password2,
        gender: event.gender,
        phone: event.phone,
      );

      try {
        RegistrationModel? registrationModel =
            await authRepo.createRegistrationModel(
          event.fName,
          event.lName,
          event.email,
          event.password1,
          event.password2,
          event.gender,
          event.phone,
        );

        if (registrationModel!.status == 200) {
          print('Registration success');
          yield state.copywith(formStatus: SubmissionSuccess());
        }
      } on Exception catch (e) {
        print('Registration Failed');
        yield state.copywith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
