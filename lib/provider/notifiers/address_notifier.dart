import 'package:flutter/material.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/repository/address_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/UserModel.dart';
import '../../error_screens.dart';
import '../../resources/common/my_snake_bar.dart';
import '../../utils/constants/constant.dart';
import '../../utils/extensions/auto_complete_address.dart';
import 'auth_notifier.dart';

class AddressNotifier extends ChangeNotifier {
  var uuid = Uuid();
  AddressRepository addressRepository = AddressRepository();

  // variables
  bool _loading = false;
  String _sessionToken = "";
  String _tappeddAddress = '';
  List<dynamic> _addressList = [];
  int _index = 0;
  int _selectedDefaultAddressIdx = -1;

  // getters
  bool get loading => _loading;
  List<dynamic> get addressList => _addressList;
  int get index => _index;
  int get selectedDefaultAddressIdx => _selectedDefaultAddressIdx;
  String get tappedAddress => _tappeddAddress;

  // setters
  void setTappedAddress(String address) {
    _tappeddAddress = address;
    notifyListeners();
  }

  void setSelectedAddress(int index) {
    _index = index;
    notifyListeners();
  }

  void setSelectedDefaultAddressIdx(int index) {
    _selectedDefaultAddressIdx = index;
    notifyListeners();
  }

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void sessionToken() {
    if (_sessionToken.isEmpty) _sessionToken = uuid.v4();
    notifyListeners();
  }

  void onBackClick() {
    _updateAddressType = "";
    _addAddressType = null;
    notifyListeners();
  }

  // Auto Adreess Suggestions Only for Canada

  Future<List> getAddressSuggestions(String input) async {
    sessionToken();
    _addressList = await AddressAutocomplete.getSuggestions(
      input,
      _sessionToken,
    );
    notifyListeners();

    return _addressList;
  }

  void onErrorHandler(
    BuildContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    showSnakeBarr(context, "$error", SnackBarState.Error);
    if (isTest) ("$error $stackTrace").log("Address notifier");
    Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

  // get lat and lng  from place id

  Future<Map<String, String>> getLatLngFromPlaceId(
      {required String placeId}) async {
    late Map<String, String>? latLngAdd;
    await addressRepository
        .getLatLngFromPlaceId(placeId: placeId)
        .then((value) {
      int _lengthOfAddress = value["result"]["address_components"].length;
      String _line1 = value["result"]["address_components"][0]["long_name"];
      String _line2 = value["result"]["address_components"][1]["long_name"];
      String _city = value["result"]["address_components"][2]["long_name"];
      String _state = "";
      for (int i = 3; i < _lengthOfAddress - 3; i++) {
        _state += "${value["result"]["address_components"][i]["long_name"]} ";
      }
      String _zip = value["result"]["address_components"][_lengthOfAddress - 1]
          ["long_name"];
      _lengthOfAddress--;
      String _country = value["result"]["address_components"]
          [_lengthOfAddress - 1]["long_name"];

      latLngAdd = {
        "latitude": value["result"]["geometry"]["location"]["lat"].toString(),
        "longitude": value["result"]["geometry"]["location"]["lng"].toString(),
        "address": value["result"]["formatted_address"].toString(),
        "line1": _line1.toString(),
        "line2": _line2.toString(),
        "city": _city.toString(),
        "state": _state.toString(),
        "country": _country.toString(),
        "zip": _zip.toString(),
      };
    }).onError((error, stackTrace) {
      ("$error $stackTrace").log("Address notifier");
    });
    return latLngAdd ?? {};
  }

  String? _addAddressType;
  String? get addAddressType => _addAddressType;

  void setAddAddressType({required String addAddressType}) {
    _addAddressType = addAddressType;
    notifyListeners();
  }

  Future<void> addAddress({
    required BuildContext context,
    required String placeId,
  }) async {
    if (_addAddressType == null) {
      showSnakeBarr(context, "Please select address type", SnackBarState.Info);
    } else {
      setLoadingState(true, true);
      final userProvider = context.read<AuthNotifier>();
      final MapSS addressBody = await getLatLngFromPlaceId(placeId: placeId);
      final _addType = <String, String>{"type": _addAddressType!};
      addressBody.addEntries(_addType.entries);
      if (isTest) addressBody.log("address body");
      addressRepository.addAddress(addressBody).then((response) {
        setLoadingState(false, true);
        var data = UserModel.fromJson(response).user!;
        User user = userProvider.user.copyWith(savedAddress: data.savedAddress);
        userProvider.setUser(user);
        showSnakeBarr(
            context, response['response_message'], SnackBarState.Success);
        _addAddressType = null;
        if (isTest) ("Address added").log();
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        setLoadingState(false, true);
        onErrorHandler(context, error, stackTrace);
      });
    }
  }

  String _updateAddressType = "";
  String get updateAddressType => _updateAddressType;

  void setUpdateAddressType({required String updateAddressType}) {
    _updateAddressType = updateAddressType;
    notifyListeners();
  }

  Future updateAddress({
    required BuildContext context,
    // required MapSS body,
    required String placeId,
    required String addressId,
  }) async {
    setLoadingState(true, true);
    final userProvider = context.read<AuthNotifier>();

    MapSS addressBody = await getLatLngFromPlaceId(placeId: placeId);

    final _addId = <String, String>{"address_id": addressId};
    final _addType = <String, String>{"type": _updateAddressType};
    addressBody.addEntries(_addId.entries);
    addressBody.addEntries(_addType.entries);
    if (isTest) addressBody.log("update address body");
    addressRepository.updateAddress(addressBody).then((response) {
      setLoadingState(false, true);
      var data = UserModel.fromJson(response).user!;
      User user = userProvider.user.copyWith(savedAddress: data.savedAddress);
      userProvider.setUser(user);
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
      if (isTest) ("Address updated").log();
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  Future deleteAddress({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    final userProvider = context.read<AuthNotifier>();
    addressRepository.deleteAddress(body).then((response) {
      setLoadingState(false, true);
      var data = UserModel.fromJson(response).user!;
      User user = userProvider.user.copyWith(savedAddress: data.savedAddress);
      userProvider.setUser(user);
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
      if (isTest) ("Address deleted").log();
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  // update default address change default address
  Future updateDefaultAddress({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    // final userProvider = context.read<AuthNotifier>();
    addressRepository.setDefaultAddress(body).then((response) {
      setLoadingState(false, true);
      showSnakeBarr(
        context,
        // response['response_message'],
        "Default Address Changed Successfully",
        SnackBarState.Success,
      );
      if (isTest) ("Default Address updated").log();
      //Navigator.pop(context);
      //(response).log("default address");
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  int? _defaultAddressIndex;
  int? get defaultAddressIndex => _defaultAddressIndex;

  int getDefaultAddressIndex(BuildContext context) {
    final userProvider = context.watch<AuthNotifier>();
    final address = userProvider.user.savedAddress;
    if (address?.length != null) {
      for (int i = 0; i < address!.length; i++) {
        if (address[i].isDefault == 1) {
          _defaultAddressIndex = i;
        }
      }
    }
    if (_defaultAddressIndex != null) return _defaultAddressIndex!;
    return -1;
  }
}
