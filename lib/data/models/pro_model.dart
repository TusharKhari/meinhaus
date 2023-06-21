class ProModel {
  String? responseCode;
  String? responseMessage;
  Prodata? prodata;

  ProModel({this.responseCode, this.responseMessage, this.prodata});

  ProModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    prodata =
        json['prodata'] != null ? new Prodata.fromJson(json['prodata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.prodata != null) {
      data['prodata'] = this.prodata!.toJson();
    }
    return data;
  }
}

class Prodata {
  int? proId;
  String? proName;
  String? proProfileUrl;
  String? proCompanyName;
  String? proMotive;
  bool? verified;
  int? jobsDone;
  List<String>? serviceOffered;
  ProRating? proRating;
  List<ProRecentProjects>? proRecentProjects;

  Prodata(
      {this.proId,
      this.proName,
      this.proProfileUrl,
      this.proCompanyName,
      this.proMotive,
      this.verified,
      this.jobsDone,
      this.serviceOffered,
      this.proRating,
      this.proRecentProjects});

  Prodata.fromJson(Map<String, dynamic> json) {
    proId = json['pro_id'];
    proName = json['pro_name'];
    proProfileUrl = json['pro_profile_url'];
    proCompanyName = json['pro_company_name'];
    proMotive = json['pro_motive'];
    verified = json['verified'];
    jobsDone = json['jobs_done'];
    serviceOffered = json['service_offered'].cast<String>();
    proRating = json['pro_rating'] != null
        ? new ProRating.fromJson(json['pro_rating'])
        : null;
    if (json['pro_recent_projects'] != null) {
      proRecentProjects = <ProRecentProjects>[];
      json['pro_recent_projects'].forEach((v) {
        proRecentProjects!.add(new ProRecentProjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pro_id'] = this.proId;
    data['pro_name'] = this.proName;
    data['pro_profile_url'] = this.proProfileUrl;
    data['pro_company_name'] = this.proCompanyName;
    data['pro_motive'] = this.proMotive;
    data['verified'] = this.verified;
    data['jobs_done'] = this.jobsDone;
    data['service_offered'] = this.serviceOffered;
    if (this.proRating != null) {
      data['pro_rating'] = this.proRating!.toJson();
    }
    if (this.proRecentProjects != null) {
      data['pro_recent_projects'] =
          this.proRecentProjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProRating {
  dynamic? avgRating;
  int? totalRating;
  int? punctuality;
  int? quality;
  int? responsiveness;

  ProRating(
      {this.avgRating,
      this.totalRating,
      this.punctuality,
      this.quality,
      this.responsiveness});

  ProRating.fromJson(Map<String, dynamic> json) {
    avgRating = json['avg_rating'];
    totalRating = json['total_rating'];
    punctuality = json['punctuality'];
    quality = json['quality'];
    responsiveness = json['responsiveness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_rating'] = this.avgRating;
    data['total_rating'] = this.totalRating;
    data['punctuality'] = this.punctuality;
    data['quality'] = this.quality;
    data['responsiveness'] = this.responsiveness;
    return data;
  }
}

class ProRecentProjects {
  int? projectId;
  String? projectName;
  dynamic? avgRating;
  String? review;
  List<String>? beforeWorkImages;
  List<String>? afterWorkImages;

  ProRecentProjects(
      {this.projectId,
      this.projectName,
      this.avgRating,
      this.review,
      this.beforeWorkImages,
      this.afterWorkImages});

  ProRecentProjects.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    avgRating = json['avg_rating'];
    review = json['review'];
    beforeWorkImages = json['before_work_images'].cast<String>();
    afterWorkImages = json['after_work_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['avg_rating'] = this.avgRating;
    data['review'] = this.review;
    data['before_work_images'] = this.beforeWorkImages;
    data['after_work_images'] = this.afterWorkImages;
    return data;
  }
}
