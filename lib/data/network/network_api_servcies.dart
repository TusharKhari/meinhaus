import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../local db/user_prefrences.dart';
import '../../utils/enum.dart';
import '../exception/app_exception.dart';

typedef MapSS = Map<String, String>;
typedef ResponseType = Map<String, dynamic>;

//=================

class NetworkApiServices {
  final dio = Dio();

  // SEND HTTP REQUEST WITH HEADER
  Future sendHttpRequest({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    bool? allowUnauthorizedResponse = false,
  }) async {
    final uri = url;

    if (body != null && isTest) (body).log("${uri.path}");

    dynamic responseJson;
    final getHeader = await UserPrefrences().getHeader();
    //  print(getHeader);
    final postHeader = await UserPrefrences().postHeader();

    try {
      late final http.Request request;
      switch (method) {
        case HttpMethod.get:
          request = http.Request('GET', uri);
          request.headers.addAll(getHeader);
          break;
        case HttpMethod.post:
          request = http.Request('POST', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          request.headers.addAll(postHeader);
          break;
        case HttpMethod.put:
          request = http.Request('PUT', uri);
          request.body = json.encode(body);
          request.headers.addAll(postHeader);
          break;
        case HttpMethod.delete:
          request = http.Request('DELETE', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          request.headers.addAll(postHeader);
          break;
      }

      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      if(isTest) (response.body).log();
      final xsrf = response.headers['set-cookie'];
      await UserPrefrences().setXsrf(xsrf.toString());
      responseJson = errorHandling(response, allowUnauthorizedResponse);
      if(isTest) (response.statusCode).log(response.request!.url.path.toString());
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

// for google sign in
  Future postApiWithoutHeader(Uri url, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      http.Response res = await http.post(url, body: data);
      responseJson = errorHandling(res, false);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  // SEND HTTP REQUEST WITHOUT HEADER
  Future sendHttpRequestWithoutToken({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    bool? allowUnauthorizedResponse = false,
  }) async {
    final uri = url;
    if (body != null) (body).log("${uri.path}");
    dynamic responseJson;
    try {
      late final http.Request request;
      switch (method) {
        case HttpMethod.get:
          request = http.Request('GET', uri);
          break;
        case HttpMethod.post:
          request = http.Request('POST', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          break;
        case HttpMethod.put:
          request = http.Request('PUT', uri);
          request.body = json.encode(body);
          break;
        case HttpMethod.delete:
          request = http.Request('DELETE', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          break;
      }
      request.headers.addAll({'Accept': 'application/json'});
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      (response.body).log();
      responseJson = errorHandling(response, allowUnauthorizedResponse);
      (response.statusCode).log(response.request!.url.path.toString());
      return responseJson;
    } on FormatException {
      throw FetchDataException("Internal server error");
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // SNED FILES WITH DIO REQUEST
  Future<dynamic> sendDioRequest({
    required Uri url,
    required HttpMethod method,
    Map<String, dynamic>? body,
  }) async {
    final dio = Dio();
    final getHeader = await UserPrefrences().getHeader();
    final postHeader = await UserPrefrences().postHeader();
    if (body != null) (body).log("${url.path}");
    try {
      late final Response<dynamic> response;
      switch (method) {
        case HttpMethod.get:
          response = await dio.getUri(
            url,
            options: Options(headers: getHeader),
          );
          break;
        case HttpMethod.post:
          response = await dio.postUri(
            url,
            data: FormData.fromMap(body!),
            options: Options(headers: postHeader),
            // onReceiveProgress: (count, total) => print(count/total *100),
            // onSendProgress: (count, total) => print((count/total *100)),
          );
          break;
        case HttpMethod.put:
          response = await dio.putUri(
            url,
            data: FormData.fromMap(body!),
            options: Options(headers: postHeader),
          );
          break;
        case HttpMethod.delete:
          response = await dio.deleteUri(
            url,
            data: FormData.fromMap(body!),
            options: Options(headers: postHeader),
          );
          break;
      }
       (response.statusCode)!.log(response.realUri.path);
      if (response.statusCode == 200 || response.statusCode == 201)
        return response.data;
      else
        ('API call failed').log("${url.path}");
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout ||
          e.type == DioException.sendTimeout ||
          e.type == DioException.receiveTimeout) {
        throw FetchDataException("Request Timeout");
      } else if (e.type == DioException.requestCancelled) {
        throw FetchDataException("Request Cancelled");
      } else {
        throw FetchDataException("Error occurred while making the request");
      }
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      throw e;
    }
  }

  // ERROR HANDLING
  dynamic errorHandling(
    http.Response response,
    bool? allowUnauthorizedResponse,
  ) {
    final code = response.statusCode;
    dynamic responseJson = code != 500 ? jsonDecode(response.body) : null;
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw FetchDataException(responseJson['response_message']);
      case 401:
        if (allowUnauthorizedResponse!) {
          return responseJson;
        } else {
          throw UnauthorizedException();
        }
      case 404:
        throw FetchDataException(responseJson['response_message']);
      case 500:
        throw InternalSeverException("");
      default:
        throw FetchDataException("with status code : ${response.statusCode}");
    }
  }
}
