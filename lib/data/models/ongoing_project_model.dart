class OngoingProjectsModel {
  String? responseCode;
  String? responseMessage;
  List<Projects>? projects;

  OngoingProjectsModel(
      {this.responseCode, this.responseMessage, this.projects});

  OngoingProjectsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Projects {
  int? id;
  String? projectName;
  String? estimateNo;
  String? projectStartDate;
  String? projectCost;
  String? description;
  List<String>? projectImages;
  bool? normal;
  bool? isCompleted;
  List<Services>? services;

  Projects(
      {this.id,
      this.projectName,
      this.estimateNo,
      this.projectStartDate,
      this.projectCost,
      this.description,
      this.projectImages,
      this.normal,
      this.isCompleted,
      this.services});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    estimateNo = json['estimate_no'];
    projectStartDate = json['project_start_date'];
    projectCost = json['project_cost'];
    description = json['description'];
    projectImages = json['project_images'].cast<String>();
    normal = json['normal'];
    isCompleted = json['is_completed'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_name'] = this.projectName;
    data['estimate_no'] = this.estimateNo;
    data['project_start_date'] = this.projectStartDate;
    data['project_cost'] = this.projectCost;
    data['description'] = this.description;
    data['project_images'] = this.projectImages;
    data['normal'] = this.normal;
    data['is_completed'] = this.isCompleted;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? projectId;
  String? serviceName;
  String? bookingId;
  String? projectCost;
  String? dateAssigned;
  String? proId;
  List<String>? images;
  bool? isCompleted;

  Services(
      {this.projectId,
      this.serviceName,
      this.bookingId,
      this.projectCost,
      this.dateAssigned,
      this.proId,
      this.images,
      this.isCompleted});

  Services.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    serviceName = json['service_name'];
    bookingId = json['booking_id'];
    projectCost = json['project_cost'];
    dateAssigned = json['date_assigned'];
    proId = json['pro_id'];
    images = json['images'].cast<String>();
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['service_name'] = this.serviceName;
    data['booking_id'] = this.bookingId;
    data['project_cost'] = this.projectCost;
    data['date_assigned'] = this.dateAssigned;
    data['pro_id'] = this.proId;
    data['images'] = this.images;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}