import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:new_user_side/data/models/pro_model.dart';
import 'package:new_user_side/data/models/progress_invoice_model.dart';
import 'package:new_user_side/data/models/project_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/repository/estimate_repository.dart';
import 'package:new_user_side/res/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../data/models/generated_estimate_model.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/invoice/screens/progess_invoice_screen.dart';
import '../../utils/utils.dart';

class EstimateNotifier extends ChangeNotifier {
  EstimateRepository estimateRepository = EstimateRepository();
  // variables
  List<XFile> _images = [];
  bool _loading = false;
  bool _reviewLoading = false;
  OngoingProjectsModel _ongoingProjects = OngoingProjectsModel();
  OngoingProjectsModel _projectsHistory = OngoingProjectsModel();
  GeneratedEstimateModel _estimateModel = GeneratedEstimateModel();
  ProjectDetailsModel _detailsModel = ProjectDetailsModel();
  ProModel _proModel = ProModel();
  ProgressInvoiceModel _progressInvoiceModel = ProgressInvoiceModel();

  // getters
  bool get loading => _loading;
  bool get reviewLoading => _reviewLoading;
  List<XFile> get images => _images;
  OngoingProjectsModel get ongoingProjects => _ongoingProjects;
  OngoingProjectsModel get projectsHistory => _projectsHistory;
  GeneratedEstimateModel get estimated => _estimateModel;
  ProjectDetailsModel get projectDetails => _detailsModel;
  ProModel get proDetails => _proModel;
  ProgressInvoiceModel get progressInvoiceModel => _progressInvoiceModel;

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setReviewLoadingState(bool state, bool notify) {
    _reviewLoading = state;
    if (notify) notifyListeners();
  }

  void setOngoingProjects(OngoingProjectsModel ongoingProjects) {
    _ongoingProjects = ongoingProjects;
    notifyListeners();
  }

  void setProjectsHistory(OngoingProjectsModel projectHisory) {
    _projectsHistory = projectHisory;
    notifyListeners();
  }

  void setEstimate(GeneratedEstimateModel estimateModel) {
    _estimateModel = estimateModel;
    notifyListeners();
  }

  void setProjectDetails(ProjectDetailsModel projectDetails) {
    _detailsModel = projectDetails;
    notifyListeners();
  }

  void setProDetails(ProModel proDetails) {
    _proModel = proDetails;
    notifyListeners();
  }

  void setProgressInvoice(ProgressInvoiceModel invoiceModel) {
    _progressInvoiceModel = invoiceModel;
    notifyListeners();
  }

// Create Estimate
  Future createEstimate({
    required BuildContext context,
    required Map<String, Object?> data,
  }) async {
    setLoadingState(true, true);
    estimateRepository.createEstimate(data).then((response) {
      setLoadingState(false, true);
      ('Estimate Succesfully Created ✅').log("Estimate Creation");
      setImagesInList([]);
      Get.to(() => HomeScreen());
      Utils.snackBar(
        "Estimate Succesfully Created.",
        "Your estimate has been created successfully..! we will contact you shortly",
      );
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", BarState.Error);
      ("${error} $stackTrace").log("Create Estimate notifier");
    });
  }

// Get Estimate
  Future getEstimateWork() async {
    estimateRepository.getEstimates().then((response) {
      var data = GeneratedEstimateModel.fromJson(response);
      setEstimate(data);
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Estimate notifier");
    });
  }

// Get Ongoing Projects
  Future getOngoingProjects() async {
    estimateRepository.getOngoingProjects().then((response) {
      var data = OngoingProjectsModel.fromJson(response);
      setOngoingProjects(data);
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Ongoing Estimate notifier");
    });
  }

  // Get Projects History
  Future getProjectsHistory() async {
    estimateRepository.getProjectsHistory().then((response) {
      var data = OngoingProjectsModel.fromJson(response);
      setProjectsHistory(data);
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Ongoing Estimate notifier");
    });
  }

// Get Project and Pro Details
  Future getProjectDetails({
    required BuildContext context,
    required String id,
    required String proId,
  }) async {
    final bool hasProData = proDetails.prodata != null;
    final bool hasProjects = projectDetails.services != null;
    if ((hasProData && hasProjects) &&
        (id == projectDetails.services!.projectId.toString() &&
            proId == proDetails.prodata!.proId.toString())) {
      ("Same project").log("Ongoing jobs");
    } else {
      setLoadingState(true, true);
      await estimateRepository.getProjectDetails(id).then((response) {
        var data = ProjectDetailsModel.fromJson(response);
        setProjectDetails(data);
      }).onError((error, stackTrace) {
        setLoadingState(false, true);
        showSnakeBarr(context, error.toString(), BarState.Error);
        ("${error} $stackTrace").log("Get Prokject Details Estimate notifier");
      });
      await estimateRepository.getProDetails(proId).then((response) {
        var data = ProModel.fromJson(response);
        setProDetails(data);
      }).onError((error, stackTrace) {
        setLoadingState(false, true);
        showSnakeBarr(context, error.toString(), BarState.Error);
        ("${error} $stackTrace").log("Get Pro Details Estimate notifier");
      });
      setLoadingState(false, true);
    }
  }

  // Progess Invoice
  Future progressInvoice({
    required BuildContext context,
    required String bookingId,
  }) async {
    setLoadingState(true, true);
    estimateRepository.progressInvoice(bookingId).then((response) {
      setLoadingState(false, true);
      Get.to(() => ProgressInvoiceScreen());
      var data = ProgressInvoiceModel.fromJson(response);
      setProgressInvoice(data);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", BarState.Error);
      ("${error} $stackTrace").log("Progress-Invocie Estimate notifier");
    });
  }

  Future toggleService({
    required BuildContext context,
    required MapSS body,
  }) async {
    await estimateRepository.toggleServices(body).then((response) {
      showSnakeBarr(context, response["response_message"], BarState.Success);
      getEstimateWork();
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", BarState.Error);
      ("${error} $stackTrace").log("Toggle Service Estimate notifier");
    });
  }

  // write a review
  Future writeReview({
    required BuildContext context,
    required MapSS body,
  }) async {
    setReviewLoadingState(true, true);
    await estimateRepository.writeReview(body).then((response) {
      showSnakeBarr(context, response["response_message"], BarState.Success);
      Navigator.pop(context);
      setReviewLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", BarState.Error);
      ("${error} $stackTrace").log("Toggle Service Estimate notifier");
      setReviewLoadingState(false, true);
    });
  }
}
