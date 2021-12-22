import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';
import 'package:neosoft_training_app/screens/profile/reset_password/reset_password_model.dart';

class ResetPasswordState {
  ResetPasswordModel? resetPasswordMode;
  ProfileDetailsModel? profileDetailsModel;
  ResetPasswordState({this.resetPasswordMode, this.profileDetailsModel});
}

class SubmittingData extends ResetPasswordState {}

class SubmissionFailureState extends ResetPasswordState {
  String exp;
  SubmissionFailureState(this.exp);
}
