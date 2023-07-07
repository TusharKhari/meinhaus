import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownLoadFiles {
  Future openFile({String? url, String? fileNmae}) async {
    final file = await downloadFile(
      "https://www.irs.gov/pub/irs-pdf/p463.pdf",
      "Newx.pdf",
    );
    if (file == null) return;
    print('Path: ${file.path}');
    try {
      print("in try block");
      OpenFile.open(
          "/data/user/0/com.example.new_user_side/app_flutter/meinHaus.pdf");
    } catch (e) {
      print("error in opne file $e");
    }
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      print("trying");
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(seconds: 10),
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      print("file ==== $file");
      return file;
    } catch (e) {
      return null;
    }
  }
}
