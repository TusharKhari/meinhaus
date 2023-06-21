import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/features/edit%20profile/controller/provider/edit_profile_notifier.dart';
import 'package:new_user_side/provider/notifiers/additional_work_notifier.dart';
import 'package:new_user_side/provider/notifiers/customer_support_notifier.dart';
import 'package:new_user_side/provider/notifiers/saved_notes_notifier.dart';
import 'package:new_user_side/provider/notifiers/upload_image_notifier.dart';
import 'package:provider/provider.dart';

import '../../provider/notifiers/estimate_notifier.dart';

class GetImages {
  final _picker = ImagePicker();

  Future pickImages<T>({
    required BuildContext context,
  }) async {
    final notifier = context.read<T>();
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      if (notifier is EstimateNotifier) {
        notifier.setImagesInList(pickedFiles);
        print(notifier.images.length);
      } else if (notifier is AdditionalWorkNotifier) {
        notifier.setImagesInList(pickedFiles);
        print(notifier.images.length);
      } else if (notifier is SavedNotesNotifier) {
        notifier.setImagesInList(pickedFiles);
        print(notifier.images.length);
      } else if (notifier is CustomerSupportNotifier) {
        notifier.setImagesInList(pickedFiles);
        print(notifier.images.length);
      } else if (notifier is UploadImgNotifier) {
        notifier.setImagesInList(pickedFiles);
        print(notifier.images.length);
      }
    } else {
      print("No images picked");
    }
  }

  Future pickImage({
    required BuildContext context,
  }) async {
    final image = context.read<EditProfileNotifier>();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.setProfileImg(pickedFile);
      print(image.image.path);
    } else {
      print("No image picked");
    }
  }
}
