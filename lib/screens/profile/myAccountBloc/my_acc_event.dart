abstract class ProfileDetailEvent {}

class EditDetailPressed extends ProfileDetailEvent {
  final String token;

  EditDetailPressed(this.token);
}
