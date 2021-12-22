import 'dart:convert';

import 'package:neosoft_training_app/screens/signUp/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static SharedPreferences? preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  // !---
  static const _imageKey = 'profile_pic';

  static Future setUser(LoginModel logModel) async {
    preferences ??= await SharedPreferences.getInstance();
    final json = jsonEncode(logModel.toJson());
    final userId = (logModel.data.id).toString();

    await preferences!.setString(userId, json);
  }

  static LoginModel getUser(String userId) {
    final json = preferences!.getString(userId);
    return LoginModel.fromJson(jsonDecode(json!));
  }

  static Future setProfilePicture(LoginModel model) async {
    preferences ??= await SharedPreferences.getInstance();

    final json = jsonEncode(model.toJson());
    final imagePath = (model.data.profilePic).toString();
    String image = imagePath.isEmpty || imagePath.contains('null')
        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
        : imagePath;
    await preferences!.setString(_imageKey, image);
  }

  static String? getProfilePicture() => preferences!.getString(_imageKey);

  //
  static Future removeProfilePic() async =>
      await preferences!.remove(_imageKey);
}
