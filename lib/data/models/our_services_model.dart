class OurServicesModel {
  String? responseCode;
  List<Services>? services;

  OurServicesModel({this.responseCode, this.services});

  OurServicesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? description;
  String? serviceDescImage;
  int? ratedPro;

  Services(
      {this.id,
      this.name,
      this.description,
      this.serviceDescImage,
      this.ratedPro});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    serviceDescImage = json['service_desc_image'];
    ratedPro = json['rated_pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['service_desc_image'] = this.serviceDescImage;
    data['rated_pro'] = this.ratedPro;
    return data;
  }
}