import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/UserModel.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/res/common/api_url/api_urls.dart';
import 'package:new_user_side/res/common/my_snake_bar.dart';
import 'package:provider/provider.dart';
import '../../../../local/user_prefrences.dart';
import '../../../../utils/constants/error_handling.dart';

typedef RequestBody = Map<String, String>;

class EditProfileServices {
  // edit profile
  Future<void> editProfile({
    required BuildContext context,
    required XFile img,
    required String firstName,
    required String lastName,
  }) async {
    final authToken = await UserPrefrences().getToken() ?? "";
    final userNotifier = context.read<AuthNotifier>();
    try {
      final request = http.MultipartRequest("POST", ApiUrls.updateProfile);

      // Attach the first name and last name as form fields
      request.fields['firstname'] = firstName;
      request.fields['lastname'] = lastName;
      request.headers['Authorization'] = 'Bearer $authToken';

      if (img.path.isNotEmpty) {
        var imageFile = await http.MultipartFile.fromPath(
          'profile_pic',
          img.path,
        );
        request.files.add(imageFile);
      }

      var response = await http.Response.fromStream(await request.send());
      print("Status code at profile update = ${response.statusCode}");

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var data = UserModel.fromJson(jsonDecode(response.body.toString()));
          final user = data.user;
          userNotifier.setUser(user!);
          showSnakeBarr(context, "Profile Updation done", BarState.Success);
          print("Profile Updated ✅");
        },
      );
    } catch (e) {
      showSnakeBarr(context, "Catch in Edit Profile --> $e 🐛", BarState.Error);
      print("Catch in Edit Profile --> $e 🐛");
    }
  }
}
