abstract class BaseApiServices {
  Future<dynamic> getApiResponse(Uri url);
  Future<dynamic> getPostApiResponse(
    Uri url,
    Map<String, dynamic> data,
  );
  Future<dynamic> postApiWithoutHeader(
    Uri url,
    Map<String, dynamic> data,
  );
}
