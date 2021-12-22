abstract class ResetPassEvent {}

class ResetButtonPressed extends ResetPassEvent {
  final String token;
  final String curPass;
  final String pass1;
  final String pass2;

  ResetButtonPressed(this.token, this.curPass, this.pass1, this.pass2);
}
