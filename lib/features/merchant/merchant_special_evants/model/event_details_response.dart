import 'dart:convert';

class EventDetailsResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  EventDetailsResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  EventDetailsResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      EventDetailsResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory EventDetailsResponse.fromRawJson(String str) =>
      EventDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventDetailsResponse.fromJson(Map<String, dynamic> json) =>
      EventDetailsResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  int? id;
  String? type;
  String? name;
  String? discount;
  String? onOffer;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? description;
  BusinessProfile? businessProfile;

  Data({
    this.id,
    this.type,
    this.name,
    this.discount,
    this.onOffer,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.description,
    this.businessProfile,
  });

  Data copyWith({
    int? id,
    String? type,
    String? name,
    String? discount,
    String? onOffer,
    DateTime? startDate,
    DateTime? endDate,
    String? startTime,
    String? endTime,
    String? description,
    BusinessProfile? businessProfile,
  }) =>
      Data(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        discount: discount ?? this.discount,
        onOffer: onOffer ?? this.onOffer,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        description: description ?? this.description,
        businessProfile: businessProfile ?? this.businessProfile,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        discount: json["discount"],
        onOffer: json["on_offer"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        description: json["description"],
        businessProfile: json["business_profile"] == null
            ? null
            : BusinessProfile.fromJson(json["business_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "discount": discount,
        "on_offer": onOffer,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "description": description,
        "business_profile": businessProfile?.toJson(),
      };
}

class BusinessProfile {
  int? id;
  String? venueName;
  String? status;
  String? address;

  BusinessProfile({
    this.id,
    this.venueName,
    this.status,
    this.address,
  });

  BusinessProfile copyWith({
    int? id,
    String? venueName,
    String? status,
    String? address,
  }) =>
      BusinessProfile(
        id: id ?? this.id,
        venueName: venueName ?? this.venueName,
        status: status ?? this.status,
        address: address ?? this.address,
      );

  factory BusinessProfile.fromRawJson(String str) =>
      BusinessProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BusinessProfile.fromJson(Map<String, dynamic> json) =>
      BusinessProfile(
        id: json["id"],
        venueName: json["venue_name"],
        status: json["status"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_name": venueName,
        "status": status,
        "address": address,
      };
}
