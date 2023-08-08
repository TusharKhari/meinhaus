import 'package:flutter/material.dart' show immutable;
import 'package:new_user_side/data/network/network_api_servcies.dart';

import '../utils/enum.dart';

@immutable
class Repository {
  final NetworkApiServices services;

  Repository({required this.services});

  Future<ResponseType> get(Uri url) async {
    try {
      return await services.sendHttpRequest(
        url: url,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }
}
