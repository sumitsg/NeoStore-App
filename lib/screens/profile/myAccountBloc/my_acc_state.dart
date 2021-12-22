import 'package:neosoft_training_app/screens/profile/profile_details_model.dart';

class ProfileDetailState {
  ProfileDetailsModel? profileDetailsModel;
  ProfileDetailState({this.profileDetailsModel});
}

class ProfileLoading extends ProfileDetailState {}

class ProfileFailureState extends ProfileDetailState {
  String exp;
  ProfileFailureState(this.exp);
}
