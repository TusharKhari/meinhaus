// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? responseCode;
  String? responseMessage;
  User? user;

  UserModel({this.responseMessage, this.user, String? responseCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['status'] = this.responseMessage;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  UserModel copyWith(
      {String? responseMessage, User? user, String? responseCode}) {
    return UserModel(
      responseCode: responseCode ?? this.responseCode,
      responseMessage: responseMessage ?? this.responseMessage,
      user: user ?? this.user,
    );
  }
}

class User {
  String? email;
  String? firstname;
  String? lastname;
  String? profilePic;
  String? contact;
  List<SavedAddress>? savedAddress;
  List<SavedCards>? savedCards;
  String? token;
  bool? isSocialLogin;

  User({
    this.email,
    this.firstname,
    this.lastname,
    this.profilePic,
    this.contact,
    this.savedAddress,
    this.savedCards,
    this.token,
    this.isSocialLogin,
  });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profilePic = json['profile_pic'];
    contact = json['contact'];
    if (json['saved_address'] != null) {
      savedAddress = <SavedAddress>[];
      json['saved_address'].forEach((v) {
        savedAddress!.add(new SavedAddress.fromJson(v));
      });
    }
    if (json['saved_cards'] != null) {
      savedCards = <SavedCards>[];
      json['saved_cards'].forEach((v) {
        savedCards!.add(new SavedCards.fromJson(v));
      });
    }
    token = json['token'];
    isSocialLogin = json['is_social_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['profile_pic'] = this.profilePic;
    data['contact'] = this.contact;
    if (this.savedAddress != null) {
      data['saved_address'] =
          this.savedAddress!.map((v) => v.toJson()).toList();
    }
    if (this.savedCards != null) {
      data['saved_cards'] = this.savedCards!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    data['is_social_login'] = this.isSocialLogin;
    return data;
  }

  User copyWith({
    String? email,
    String? firstname,
    String? lastname,
    String? profilePic,
    String? contact,
    List<SavedAddress>? savedAddress,
    List<SavedCards>? savedCards,
    String? token,
    bool? isSocialLogin,
  }) {
    return User(
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePic: profilePic ?? this.profilePic,
      contact: contact ?? this.contact,
      savedAddress: savedAddress ?? this.savedAddress,
      savedCards: savedCards ?? this.savedCards,
      token: token ?? this.token,
      isSocialLogin: isSocialLogin ?? this.isSocialLogin,
    );
  }
}

class SavedAddress {
  int? id;
  String? userId;
  String? line1;
  String? line2;
  String? city;
  String? state;
  String? country;
  String? zip;
  String? phone;
  String? type;
  String? isDefault;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  SavedAddress(
      {this.id,
      this.userId,
      this.line1,
      this.line2,
      this.city,
      this.state,
      this.country,
      this.zip,
      this.phone,
      this.type,
      this.isDefault,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SavedAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    line1 = json['line1'];
    line2 = json['line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    phone = json['phone'];
    type = json['type'];
    isDefault = json['is_default'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  SavedAddress copyWith({
    int? id,
    String? userId,
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? country,
    String? zip,
    String? phone,
    String? type,
    String? isDefault,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    Null? deletedAt,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

class SavedCards {
  String? id;
  String? brand;
  String? lastFour;
  int? expMonth;
  int? expYear;
  String? cardHolderName;

  SavedCards(
      {this.id,
      this.brand,
      this.lastFour,
      this.expMonth,
      this.expYear,
      this.cardHolderName});

  SavedCards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    lastFour = json['last_four'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    cardHolderName = json['card_holder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['last_four'] = this.lastFour;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['card_holder_name'] = this.cardHolderName;
    return data;
  }

  SavedCards copyWith({
    String? id,
    String? brand,
    String? lastFour,
    int? expMonth,
    int? expYear,
    String? cardHolderName,
  }) {
    return SavedCards(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      lastFour: lastFour ?? this.lastFour,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      cardHolderName: cardHolderName ?? this.cardHolderName,
    );
  }
}
