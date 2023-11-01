import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/additional_work_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/repository/additional_work_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../error_screens.dart';
import '../../resources/common/my_snake_bar.dart';
import '../../static components/dialogs/additional_work_added_dialog.dart';
import '../../utils/extensions/get_images.dart';

class AdditionalWorkNotifier extends ChangeNotifier {
  AdditionalWorkRepo repo = AdditionalWorkRepo();
  //variables
  bool _loading = false;
  List<XFile> _images = [];
  AdditionalWorkModel _additionalWork = AdditionalWorkModel();

  //getters
  bool get loading => _loading;
  List<XFile> get images => _images;
  AdditionalWorkModel get additionalWork => _additionalWork;

  //setters
  
  //function

  void onBackClick(){
    _images = [];
    notifyListeners();
  }

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void setAdditionalWork(AdditionalWorkModel work) {
    _additionalWork = work;
    notifyListeners();
  }

  void removeImageFromList(XFile pickedFile) {
    _images.remove(pickedFile);
    notifyListeners();
  }

  Future getImagess(BuildContext context) async {
    await GetImages().pickImages<AdditionalWorkNotifier>(context: context);
  }

  void onErrorHandler(
    BuildContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    showSnakeBarr(context, "$error", SnackBarState.Error);
    ("$error $stackTrace").log("Additional Work notifier");
    Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

  //methods
  Future requestAdditonalWork({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingState(true, true);
    await repo.requestAdditionalWork(body).then((value) {
      ('Request send ✅').log("Addtional Work");
      setImagesInList([]);
      showDialog(
        context: context,
        builder: (context) {
          return const AdditionalWorkAddedDialog();
        },
      );
      // After requesting an additional work we need 
      // to refresh the additional work
      getAdditonalWork(
        context: context,
        projectId: body['estimate_service_id'],
      );
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
    });
    setLoadingState(false, true);
  }

  Future getAdditonalWork({
    required BuildContext context,
    required String projectId,
  }) async {
    setLoadingState(true, true);
    await repo.getAdditonalWork(projectId).then((response) {
      setLoadingState(false, true);
      var data = AdditionalWorkModel.fromJson(response);
      setAdditionalWork(data);
      ('Fetched Addtional work succesfully ✅').log();
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error $stackTrace").log("Additional Work notifier");
    });
  }

  Future approve({
    required BuildContext context,
    required String id,
  }) async {
    MapSS body = {"additional_work_id": id};
    setLoadingState(true, true);
    repo.approve(body).then((response) {
      setLoadingState(false, true);
      var data = AdditionalWorkModel.fromJson(response);
      setAdditionalWork(data);
      ('Approval Done Addtional work Succesfully ✅').log();
      showSnakeBar(context, 'Addtional Work Approved ✅');
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  Future reject({
    required BuildContext context,
    required String id,
  }) async {
    MapSS body = {"additional_work_id": id};
    setLoadingState(true, true);
    repo.reject(body).then((response) {
      setLoadingState(false, true);
      var data = AdditionalWorkModel.fromJson(response);
      setAdditionalWork(data);
      ('Rejection Done Addtional work successfully ❌').log();
      showSnakeBar(context, 'Addtional Work Rejected ❌');
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }
}
