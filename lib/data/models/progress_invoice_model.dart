class ProgressInvoiceModel {
  String? status;
  Data? data;

  ProgressInvoiceModel({this.status, this.data});

  ProgressInvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? bookingId;
  String? createdAt;
  String? totalAmount;
  MeinhausAddress? meinhausAddress;
  BillTo? billTo;
  List<Services>? services;
  InvoiceSummary? invoiceSummary;
  AmountToBePaid? amountToBePaid;

  Data(
      {this.bookingId,
      this.createdAt,
      this.totalAmount,
      this.meinhausAddress,
      this.billTo,
      this.services,
      this.invoiceSummary,
      this.amountToBePaid});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    createdAt = json['created_at'];
    totalAmount = json['total_amount'];
    meinhausAddress = json['meinhaus_address'] != null
        ? new MeinhausAddress.fromJson(json['meinhaus_address'])
        : null;
    billTo =
        json['bill_to'] != null ? new BillTo.fromJson(json['bill_to']) : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    invoiceSummary = json['invoice_summary'] != null
        ? new InvoiceSummary.fromJson(json['invoice_summary'])
        : null;
    amountToBePaid = json['amount_to_be_paid'] != null
        ? new AmountToBePaid.fromJson(json['amount_to_be_paid'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['created_at'] = this.createdAt;
    data['total_amount'] = this.totalAmount;
    if (this.meinhausAddress != null) {
      data['meinhaus_address'] = this.meinhausAddress!.toJson();
    }
    if (this.billTo != null) {
      data['bill_to'] = this.billTo!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.invoiceSummary != null) {
      data['invoice_summary'] = this.invoiceSummary!.toJson();
    }
    if (this.amountToBePaid != null) {
      data['amount_to_be_paid'] = this.amountToBePaid!.toJson();
    }
    return data;
  }
}

class MeinhausAddress {
  String? address1;
  String? city;
  String? province;
  String? postalCode;
  String? country;
  String? phone;
  String? website;

  MeinhausAddress(
      {this.address1,
      this.city,
      this.province,
      this.postalCode,
      this.country,
      this.phone,
      this.website});

  MeinhausAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
    country = json['country'];
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['website'] = this.website;
    return data;
  }
}

class BillTo {
  String? name;
  Address? address;
  String? phone;
  String? email;

  BillTo({this.name, this.address, this.phone, this.email});

  BillTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class Address {
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;

  Address({this.address1, this.address2, this.city, this.state, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Services {
  String? serviceName;
  String? description;
  String? amountToPay;

  Services({this.serviceName, this.description, this.amountToPay});

  Services.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    description = json['description'];
    amountToPay = json['amount_to_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
    data['amount_to_pay'] = this.amountToPay;
    return data;
  }
}

class InvoiceSummary {
  String? totalAmountPaid;
  String? remainingAmountToBePaid;
  String? totalProjectCost;
  String? hst;
  String? invoiceTotal;

  InvoiceSummary(
      {this.totalAmountPaid,
      this.remainingAmountToBePaid,
      this.totalProjectCost,
      this.hst,
      this.invoiceTotal});

  InvoiceSummary.fromJson(Map<String, dynamic> json) {
    totalAmountPaid = json['total_amount_paid'];
    remainingAmountToBePaid = json['remaining_amount_to_be_paid'];
    totalProjectCost = json['total_project_cost'];
    hst = json['hst'];
    invoiceTotal = json['invoice_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount_paid'] = this.totalAmountPaid;
    data['remaining_amount_to_be_paid'] = this.remainingAmountToBePaid;
    data['total_project_cost'] = this.totalProjectCost;
    data['hst'] = this.hst;
    data['invoice_total'] = this.invoiceTotal;
    return data;
  }
}

class AmountToBePaid {
  String? remainingProjectCost;
  String? hst;
  String? totalAmountDue;

  AmountToBePaid({this.remainingProjectCost, this.hst, this.totalAmountDue});

  AmountToBePaid.fromJson(Map<String, dynamic> json) {
    remainingProjectCost = json['remaining_project_cost'];
    hst = json['hst'];
    totalAmountDue = json['total_amount_due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remaining_project_cost'] = this.remainingProjectCost;
    data['hst'] = this.hst;
    data['total_amount_due'] = this.totalAmountDue;
    return data;
  }
}