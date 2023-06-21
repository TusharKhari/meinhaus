import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/repository/upload_img_repo.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../res/common/my_snake_bar.dart';

class UploadImgNotifier extends ChangeNotifier {
  UploadImgRepo uploadImgRepo = UploadImgRepo();
  //variables
  bool _loading = false;
  List<XFile> _images = [];

  //getters
  bool get loading => _loading;
  List<XFile> get images => _images;

  //function
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void removeImageFromList(XFile pickedFile) {
    _images.remove(pickedFile);
    notifyListeners();
  }

  // upload img
  Future uploadImg({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingState(true, true);
    uploadImgRepo.uploadImg(body).then((response) {
      setLoadingState(false, true);
      setImagesInList([]);
      ('Img Uploaded Succesfully ✅').log();
      Navigator.pop(context);
      showSnakeBarr(context, "Images Uploaded Succesfully", BarState.Success);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", BarState.Error);
      ("${error} $stackTrace").log("Saved note notifier");
    });
  }
}
