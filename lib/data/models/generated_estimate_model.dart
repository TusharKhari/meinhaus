



class GeneratedEstimateModel {
  int? responseCode;
  String? responseMessage;
  List<EstimatedWorks>? estimatedWorks;

  GeneratedEstimateModel(
      {this.responseCode, this.responseMessage, this.estimatedWorks});

  GeneratedEstimateModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    if (json['estimated_works'] != null) {
      estimatedWorks = <EstimatedWorks>[];
      json['estimated_works'].forEach((v) {
       estimatedWorks!.add(new EstimatedWorks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.estimatedWorks != null) {
      data['estimated_works'] =
          this.estimatedWorks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EstimatedWorks {
  String? projectName;
  String? estimateId;
  String? estimateDate;
  BillTo? billTo;
  BillFrom? billFrom;
  List<ProjectEstimate>? projectEstimate;
  List<UploadedImgs>? uploadedImgs;
  ProjectBilling? projectBilling;

  EstimatedWorks(
      {this.projectName,
      this.estimateId,
      this.estimateDate,
      this.billTo,
      this.billFrom,
      this.projectEstimate,
      this.uploadedImgs,
      this.projectBilling});

  EstimatedWorks.fromJson(Map<String, dynamic> json) {
    projectName = json['project_name'];
    estimateId = json['estimate_id'];
    estimateDate = json['estimate_date'];
    billTo =
        json['bill_to'] != null ? new BillTo.fromJson(json['bill_to']) : null;
    billFrom = json['bill_from'] != null
        ? new BillFrom.fromJson(json['bill_from'])
        : null;
    if (json['project_estimate'] != null) {
      projectEstimate = <ProjectEstimate>[];
      json['project_estimate'].forEach((v) {
        projectEstimate!.add(new ProjectEstimate.fromJson(v));
      });
    }
    if (json['uploaded_imgs'] != null) {
      uploadedImgs = <UploadedImgs>[];
      json['uploaded_imgs'].forEach((v) {
        uploadedImgs!.add(new UploadedImgs.fromJson(v));
      });
    }
    projectBilling = json['project_billing'] != null
        ? new ProjectBilling.fromJson(json['project_billing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_name'] = this.projectName;
    data['estimate_id'] = this.estimateId;
    data['estimate_date'] = this.estimateDate;
    if (this.billTo != null) {
      data['bill_to'] = this.billTo!.toJson();
    }
    if (this.billFrom != null) {
      data['bill_from'] = this.billFrom!.toJson();
    }
    if (this.projectEstimate != null) {
      data['project_estimate'] =
          this.projectEstimate!.map((v) => v.toJson()).toList();
    }
    if (this.uploadedImgs != null) {
      data['uploaded_imgs'] =
          this.uploadedImgs!.map((v) => v.toJson()).toList();
    }
    if (this.projectBilling != null) {
      data['project_billing'] = this.projectBilling!.toJson();
    }
    return data;
  }
}

class BillTo {
  String? name;
  String? address;
  String? country;
  String? phone;
  String? email;

  BillTo({this.name, this.address, this.country, this.phone, this.email});

  BillTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class BillFrom {
  String? name;
  String? address;
  String? country;
  String? phone;
  String? website;

  BillFrom({this.name, this.address, this.country, this.phone, this.website});

  BillFrom.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    country = json['country'];
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['website'] = this.website;
    return data;
  }
}

class ProjectEstimate {
  int? projectId;
  String? projectArea;
  String? projectDescription;
  double? depositAmount;
  double? projectCost;
  int? status;

  ProjectEstimate(
      {this.projectId,
      this.projectArea,
      this.projectDescription,
      this.depositAmount,
      this.projectCost,
      this.status});

  ProjectEstimate.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectArea = json['project_area'];
    projectDescription = json['project_description'];
    depositAmount = double.parse(json['deposit_amount'].toString());
    projectCost = double.parse(json['project_cost'].toString()) ;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_area'] = this.projectArea;
    data['project_description'] = this.projectDescription;
    data['deposit_amount'] = this.depositAmount;
    data['project_cost'] = this.projectCost;
    data['status'] = this.status;
    return data;
  }
}

class UploadedImgs {
  String? imageUrl;
  String? thumbnailUrl;

  UploadedImgs({this.imageUrl, this.thumbnailUrl});

  UploadedImgs.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    thumbnailUrl = json['thumbnail_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    return data;
  }
}

class ProjectBilling {
  double? totalCost;
  double? hstTotalCost;
  double? amountToPay;
  double? hstAmountToPay;
  double? amountPaid;
  double? amountToPayInFuture;

  ProjectBilling(
      {this.totalCost,
      this.hstTotalCost,
      this.amountToPay,
      this.hstAmountToPay,
      this.amountPaid,
      this.amountToPayInFuture});

  ProjectBilling.fromJson(Map<String, dynamic> json) {
    totalCost = double.parse(json['total_cost'].toString());
    hstTotalCost = double.parse(json['hst_total_cost'].toString());
    amountToPay = double.parse(json['amount_to_pay'].toString());
    hstAmountToPay = double.parse(json['hst_amount_to_pay'].toString());
    amountPaid = double.parse(json['amount_paid'].toString());
    amountToPayInFuture = double.parse(json['amount_to_pay_in_future'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_cost'] = this.totalCost;
    data['hst_total_cost'] = this.hstTotalCost;
    data['amount_to_pay'] = this.amountToPay;
    data['hst_amount_to_pay'] = this.hstAmountToPay;
    data['amount_paid'] = this.amountPaid;
    data['amount_to_pay_in_future'] = this.amountToPayInFuture;
    return data;
  }
}



//  ===============

// class GeneratedEstimateModel {
//   int? responseCode;
//   String? responseMessage;
//   List<EstimatedWorks>? estimatedWorks;

//   GeneratedEstimateModel(
//       {this.responseCode, this.responseMessage, this.estimatedWorks});

//   GeneratedEstimateModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     responseMessage = json['response_message'];
//     if (json['estimated_works'] != null) {
//       estimatedWorks = <EstimatedWorks>[];
//       json['estimated_works'].forEach((v) {
//         estimatedWorks!.add(new EstimatedWorks.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['response_message'] = this.responseMessage;
//     if (this.estimatedWorks != null) {
//       data['estimated_works'] =
//           this.estimatedWorks!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class EstimatedWorks {
//   String? projectName;
//   String? estimateId;
//   String? estimateDate;
//   BillTo? billTo;
//   BillFrom? billFrom;
//   List<ProjectEstimate>? projectEstimate;
//   List<UploadedImgs>? uploadedImgs;
//   ProjectBilling? projectBilling;

//   EstimatedWorks(
//       {this.projectName,
//       this.estimateId,
//       this.estimateDate,
//       this.billTo,
//       this.billFrom,
//       this.projectEstimate,
//       this.uploadedImgs,
//       this.projectBilling});

//   EstimatedWorks.fromJson(Map<String, dynamic> json) {
//     projectName = json['project_name'];
//     estimateId = json['estimate_id'];
//     estimateDate = json['estimate_date'];
//     billTo =
//         json['bill_to'] != null ? new BillTo.fromJson(json['bill_to']) : null;
//     billFrom = json['bill_from'] != null
//         ? new BillFrom.fromJson(json['bill_from'])
//         : null;
//     if (json['project_estimate'] != null) {
//       projectEstimate = <ProjectEstimate>[];
//       json['project_estimate'].forEach((v) {
//         projectEstimate!.add(new ProjectEstimate.fromJson(v));
//       });
//     }
//     if (json['uploaded_imgs'] != null) {
//       uploadedImgs = <UploadedImgs>[];
//       json['uploaded_imgs'].forEach((v) {
//         uploadedImgs!.add(new UploadedImgs.fromJson(v));
//       });
//     }
//     projectBilling = json['project_billing'] != null
//         ? new ProjectBilling.fromJson(json['project_billing'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['project_name'] = this.projectName;
//     data['estimate_id'] = this.estimateId;
//     data['estimate_date'] = this.estimateDate;
//     if (this.billTo != null) {
//       data['bill_to'] = this.billTo!.toJson();
//     }
//     if (this.billFrom != null) {
//       data['bill_from'] = this.billFrom!.toJson();
//     }
//     if (this.projectEstimate != null) {
//       data['project_estimate'] =
//           this.projectEstimate!.map((v) => v.toJson()).toList();
//     }
//     if (this.uploadedImgs != null) {
//       data['uploaded_imgs'] =
//           this.uploadedImgs!.map((v) => v.toJson()).toList();
//     }
//     if (this.projectBilling != null) {
//       data['project_billing'] = this.projectBilling!.toJson();
//     }
//     return data;
//   }
// }

// class BillTo {
//   String? name;
//   String? address;
//   String? country;
//   String? phone;
//   String? email;

//   BillTo({this.name, this.address, this.country, this.phone, this.email});

//   BillTo.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     address = json['address'];
//     country = json['country'];
//     phone = json['phone'];
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     return data;
//   }
// }

// class BillFrom {
//   String? name;
//   String? address;
//   String? country;
//   String? phone;
//   String? website;

//   BillFrom({this.name, this.address, this.country, this.phone, this.website});

//   BillFrom.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     address = json['address'];
//     country = json['country'];
//     phone = json['phone'];
//     website = json['website'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['phone'] = this.phone;
//     data['website'] = this.website;
//     return data;
//   }
// }

// class ProjectEstimate {
//   int? projectId;
//   String? projectArea;
//   String? projectDescription;
//   double ? depositAmount;
//   double? projectCost;
//   int? status;

//   ProjectEstimate(
//       {this.projectId,
//       this.projectArea,
//       this.projectDescription,
//       this.depositAmount,
//       this.projectCost,
//       this.status});

//   ProjectEstimate.fromJson(Map<String, dynamic> json) {
//     projectId = json['project_id'];
//     projectArea = json['project_area'];
//     projectDescription = json['project_description'];
//     depositAmount = json['deposit_amount'] ;
//     projectCost = json['project_cost'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['project_id'] = this.projectId;
//     data['project_area'] = this.projectArea;
//     data['project_description'] = this.projectDescription;
//     data['deposit_amount'] = this.depositAmount;
//     data['project_cost'] = this.projectCost;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class UploadedImgs {
//   String? imageUrl;
//   String? thumbnailUrl;

//   UploadedImgs({this.imageUrl, this.thumbnailUrl});

//   UploadedImgs.fromJson(Map<String, dynamic> json) {
//     imageUrl = json['image_url'];
//     thumbnailUrl = json['thumbnail_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image_url'] = this.imageUrl;
//     data['thumbnail_url'] = this.thumbnailUrl;
//     return data;
//   }
// }

// class ProjectBilling {
//   int? totalCost;
//   double? hstTotalCost;
//   double? amountToPay;
//   double? hstAmountToPay;
//   double? amountPaid;
//   double? amountToPayInFuture;

//   ProjectBilling(
//       {this.totalCost,
//       this.hstTotalCost,
//       this.amountToPay,
//       this.hstAmountToPay,
//       this.amountPaid,
//       this.amountToPayInFuture});

//   ProjectBilling.fromJson(Map<String, dynamic> json) {
//     totalCost = json['total_cost'];
//     hstTotalCost = json['hst_total_cost'];
//     amountToPay = json['amount_to_pay'];
//     hstAmountToPay = json['hst_amount_to_pay'];
//     amountPaid = json['amount_paid'];
//     amountToPayInFuture = json['amount_to_pay_in_future'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_cost'] = this.totalCost;
//     data['hst_total_cost'] = this.hstTotalCost;
//     data['amount_to_pay'] = this.amountToPay;
//     data['hst_amount_to_pay'] = this.hstAmountToPay;
//     data['amount_paid'] = this.amountPaid;
//     data['amount_to_pay_in_future'] = this.amountToPayInFuture;
//     return data;
//   }
// }


////========

// class GeneratedEstimateModel {
//   int? responseCode;
//   String? responseMessage;
//   List<EstimatedWorks>? estimatedWorks;

//   GeneratedEstimateModel(
//       {this.responseCode, this.responseMessage, this.estimatedWorks});

//   GeneratedEstimateModel.fromJson(Map<String, dynamic> json) {
//     responseCode = json['response_code'];
//     responseMessage = json['response_message'];
//     if (json['estimated_works'] != null) {
//       estimatedWorks = <EstimatedWorks>[];
//       json['estimated_works'].forEach((v) {
//         estimatedWorks!.add(new EstimatedWorks.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['response_code'] = this.responseCode;
//     data['response_message'] = this.responseMessage;
//     if (this.estimatedWorks != null) {
//       data['estimated_works'] =
//           this.estimatedWorks!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class EstimatedWorks {
//   String? projectName;
//   String? estimateId;
//   String? estimateDate;
//   BillTo? billTo;
//   BillFrom? billFrom;
//   List<ProjectEstimate>? projectEstimate;
//   List<UploadedImgs>? uploadedImgs;
//   ProjectBilling? projectBilling;

//   EstimatedWorks(
//       {this.projectName,
//       this.estimateId,
//       this.estimateDate,
//       this.billTo,
//       this.billFrom,
//       this.projectEstimate,
//       this.uploadedImgs,
//       this.projectBilling});

//   EstimatedWorks.fromJson(Map<String, dynamic> json) {
//     projectName = json['project_name'];
//     estimateId = json['estimate_id'];
//     estimateDate = json['estimate_date'];
//     billTo =
//         json['bill_to'] != null ? new BillTo.fromJson(json['bill_to']) : null;
//     billFrom = json['bill_from'] != null
//         ? new BillFrom.fromJson(json['bill_from'])
//         : null;
//     if (json['project_estimate'] != null) {
//       projectEstimate = <ProjectEstimate>[];
//       json['project_estimate'].forEach((v) {
//         projectEstimate!.add(new ProjectEstimate.fromJson(v));
//       });
//     }
//     if (json['uploaded_imgs'] != null) {
//       uploadedImgs = <UploadedImgs>[];
//       json['uploaded_imgs'].forEach((v) {
//         uploadedImgs!.add(new UploadedImgs.fromJson(v));
//       });
//     }
//     projectBilling = json['project_billing'] != null
//         ? new ProjectBilling.fromJson(json['project_billing'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['project_name'] = this.projectName;
//     data['estimate_id'] = this.estimateId;
//     data['estimate_date'] = this.estimateDate;
//     if (this.billTo != null) {
//       data['bill_to'] = this.billTo!.toJson();
//     }
//     if (this.billFrom != null) {
//       data['bill_from'] = this.billFrom!.toJson();
//     }
//     if (this.projectEstimate != null) {
//       data['project_estimate'] =
//           this.projectEstimate!.map((v) => v.toJson()).toList();
//     }
//     if (this.uploadedImgs != null) {
//       data['uploaded_imgs'] =
//           this.uploadedImgs!.map((v) => v.toJson()).toList();
//     }
//     if (this.projectBilling != null) {
//       data['project_billing'] = this.projectBilling!.toJson();
//     }
//     return data;
//   }
// }

// class BillTo {
//   String? name;
//   String? address;
//   String? country;
//   String? phone;
//   String? email;

//   BillTo({this.name, this.address, this.country, this.phone, this.email});

//   BillTo.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     address = json['address'];
//     country = json['country'];
//     phone = json['phone'];
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     return data;
//   }
// }

// class BillFrom {
//   String? name;
//   String? address;
//   String? country;
//   String? phone;
//   String? website;

//   BillFrom({this.name, this.address, this.country, this.phone, this.website});

//   BillFrom.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     address = json['address'];
//     country = json['country'];
//     phone = json['phone'];
//     website = json['website'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['phone'] = this.phone;
//     data['website'] = this.website;
//     return data;
//   }
// }

// class ProjectEstimate {
//   int? projectId;
//   String? projectArea;
//   String? projectDescription;
//   int? depositAmount;
//   int? projectCost;
//   int? status;

//   ProjectEstimate(
//       {this.projectId,
//       this.projectArea,
//       this.projectDescription,
//       this.depositAmount,
//       this.projectCost,
//       this.status});

//   ProjectEstimate.fromJson(Map<String, dynamic> json) {
//     projectId = json['project_id'];
//     projectArea = json['project_area'];
//     projectDescription = json['project_description'];
//     depositAmount = json['deposit_amount'];
//     projectCost = json['project_cost'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['project_id'] = this.projectId;
//     data['project_area'] = this.projectArea;
//     data['project_description'] = this.projectDescription;
//     data['deposit_amount'] = this.depositAmount;
//     data['project_cost'] = this.projectCost;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class UploadedImgs {
//   String? imageUrl;
//   String? thumbnailUrl;

//   UploadedImgs({this.imageUrl, this.thumbnailUrl});

//   UploadedImgs.fromJson(Map<String, dynamic> json) {
//     imageUrl = json['image_url'];
//     thumbnailUrl = json['thumbnail_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image_url'] = this.imageUrl;
//     data['thumbnail_url'] = this.thumbnailUrl;
//     return data;
//   }
// }

// class ProjectBilling {
//   int? totalCost;
//   int? hstTotalCost;
//   int? amountToPay;
//   double ? hstAmountToPay;
//   int? amountPaid;
//   int? amountToPayInFuture;

//   ProjectBilling(
//       {this.totalCost,
//       this.hstTotalCost,
//       this.amountToPay,
//       this.hstAmountToPay,
//       this.amountPaid,
//       this.amountToPayInFuture});

//   ProjectBilling.fromJson(Map<String, dynamic> json) {
//     totalCost = json['total_cost'];
//     hstTotalCost = json['hst_total_cost'];
//     amountToPay = json['amount_to_pay'];
//     hstAmountToPay = json['hst_amount_to_pay'];
//     amountPaid = json['amount_paid'];
//     amountToPayInFuture = json['amount_to_pay_in_future'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_cost'] = this.totalCost;
//     data['hst_total_cost'] = this.hstTotalCost;
//     data['amount_to_pay'] = this.amountToPay;
//     data['hst_amount_to_pay'] = this.hstAmountToPay;
//     data['amount_paid'] = this.amountPaid;
//     data['amount_to_pay_in_future'] = this.amountToPayInFuture;
//     return data;
//   }
// }
