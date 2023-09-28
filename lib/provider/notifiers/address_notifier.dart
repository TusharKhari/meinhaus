import 'package:flutter/material.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/repository/address_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/UserModel.dart';
import '../../error_screens.dart';
import '../../resources/common/my_snake_bar.dart';
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
  int  _selectedDefaultAddressIdx = -1 ;

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
   
  void setSelectedDefaultAddressIdx(int index){
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
    ("$error $stackTrace").log("Address notifier");
    Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

  Future<void> addAddress({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    final userProvider = context.read<AuthNotifier>();
    addressRepository.addAddress(body).then((response) {
      setLoadingState(false, true);
      var data = UserModel.fromJson(response).user!;
      // Need testing Done WOrking fine
      // userProvider.user.savedAddress!.insert(0, data.savedAddress![0]);
      // userProvider.updateUser();
      // User user = userProvider.user.copyWith(savedAddress: data.savedAddress);
     User user = userProvider.user.copyWith(savedAddress: data.savedAddress);

      userProvider.setUser(user);
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
      ("Address added").log();
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  Future updateAddress({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    final userProvider = context.read<AuthNotifier>();
    addressRepository.updateAddress(body).then((response) {
      setLoadingState(false, true);
      var data = UserModel.fromJson(response).user!;
      User user = userProvider.user.copyWith(savedAddress: data.savedAddress);
      userProvider.setUser(user);
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
      ("Address updated").log();
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
      ("Address deleted").log();
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
     
  })async{
      setLoadingState(true, true);
   // final userProvider = context.read<AuthNotifier>();
    addressRepository.setDefaultAddress(body).then((response) {
       setLoadingState(false, true);
        final userProvider = context.read<AuthNotifier>();
       // SavedAddress user = userProvider.user.savedAddress![indexOfAddress].copyWith(isDefault: 1)  ;
       showSnakeBarr(
          context, 
          // response['response_message'], 
          "Default Address Changed Successfully",
          SnackBarState.Success, 
          );
      ("Default Address updated").log();
      //Navigator.pop(context);
      //(response).log("default address");
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  int ? _defaultAddressIndex ;
  int? get defaultAddressIndex => _defaultAddressIndex;

   int getDefaultAddressIndex(BuildContext context){
     final userProvider = context.watch<AuthNotifier>();
    final address = userProvider.user.savedAddress;
   if(address?.length != null){
     for(int i =0; i< address!.length; i++){
      if(address[i].isDefault == 1){
        _defaultAddressIndex = i;
      }
    }
   }
   if(_defaultAddressIndex != null) return _defaultAddressIndex!;
   return -1;
  }
}