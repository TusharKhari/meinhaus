import 'package:new_user_side/utils/constants/constant.dart';

import '../data/network/network_api_servcies.dart';
import '../resources/common/api_url/api_urls.dart';
import '../utils/constants/g_map_api.dart';
import '../utils/enum.dart';

class AddressRepository {
  NetworkApiServices services = NetworkApiServices();

  // Add address
  Future<ResponseType> addAddress(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.addAddress,
        method: HttpMethod.post,
        body: body,
      );
    } on FormatException {
      throw "Internal Server Error";
    }
    catch (e) {
      throw e;
    }
  }

  // Edit address
  Future<ResponseType> editAdrress(String addressId) async {
    try {
      return await services.sendHttpRequest(
        url: Uri.parse("${ApiUrls.editAddress}id=$addressId"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // Update address
  Future<ResponseType> updateAddress(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.updateAddress,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Delete address
  Future<ResponseType> deleteAddress(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.deleteAddress,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
   
   // set default address 

   Future<ResponseType> setDefaultAddress(MapSS body) async{
   //  print("default address : $body");
    // print(ApiUrls.setDefaultAddress);
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.setDefaultAddress, 
        method: HttpMethod.post,
        body : body, 
        );
    } on FormatException{
      throw FormatException("service temporarily unavailable");
    } 
     catch (e) {
     // print("set default $e");
      throw e;
    }
   }
    Future<ResponseType> getLatLngFromPlaceId({ required placeId})async{
  //    https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJga_7fdRzhlQRh6P6ivHhNxE&key=AIzaSyC3WLUbDPnruzxcS7eT8IQ5OVYJiSiLIlU
    String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components,formatted_address,geometry&key=$kPLACES_API_KEY";
      try {
        return await services.sendHttpRequest(url: Uri.parse(url), method: HttpMethod.get);
      } catch (e) {
        throw e;
      }
    }
}


    