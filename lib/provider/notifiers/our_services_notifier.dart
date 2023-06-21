import 'package:flutter/material.dart';
import 'package:new_user_side/data/models/our_services_model.dart';
import 'package:new_user_side/repository/our_services_repo.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class OurServicesNotifier extends ChangeNotifier {
  OurServicesRepo savedNotesRepo = OurServicesRepo();
  //variables
  bool _loading = false;
  OurServicesModel _services = OurServicesModel();

  //getters
  bool get loading => _loading;
  OurServicesModel get services => _services;

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setOurServices(OurServicesModel servicesModel) {
    _services = servicesModel;
    notifyListeners();
  }

  // Get saved notes
  Future getOurServices() async {
    await savedNotesRepo.getOurServices().then((response) {
      var data = OurServicesModel.fromJson(response);
      setOurServices(data);
      ('Get Our services ✅').log();
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Our Services notifier");
    });
  }
}
