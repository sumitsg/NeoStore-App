abstract class EditProfileEvent {}

class SubmitDetailButtonPressed extends EditProfileEvent {
  final String token;
  final String fname;
  final String lname;
  final String phone;
  final String email;
  final String dob;
  final String img;

  SubmitDetailButtonPressed(
    this.token,
    this.fname,
    this.lname,
    this.email,
    this.dob,
    this.phone,
    this.img,
  );
}
