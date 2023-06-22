import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'constants/app_colors.dart';

class Utils {
  final dio = Dio();
  Utils._();
  // function to change the focus from the current textfield to another with keyboard
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //snack bar with getX
  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: AppColors.white,
      backgroundColor: AppColors.buttonBlue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }


// Collect images selected by user
  static Future<List<MultipartFile>> collectImages(List<XFile>? images) async {
    List<MultipartFile> imageFiles = [];
    for (int i = 0; i < images!.length; i++) {
      final fileBytes = await images[i].readAsBytes();
      final fileName = images[i].name;
      final imageFile = await MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );
      imageFiles.add(imageFile);
    }
    return await imageFiles;
  }

// Getting the lat and long form address
  static Future<List<Location>> getCordinates(String address) async {
    return await locationFromAddress(address);
  }


}
