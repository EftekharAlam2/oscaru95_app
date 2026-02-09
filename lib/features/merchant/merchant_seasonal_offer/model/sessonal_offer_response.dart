import 'dart:convert';

class SeasonalOfferResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  SeasonalOfferResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  SeasonalOfferResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) =>
      SeasonalOfferResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory SeasonalOfferResponse.fromRawJson(String str) =>
      SeasonalOfferResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SeasonalOfferResponse.fromJson(Map<String, dynamic> json) =>
      SeasonalOfferResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  int? id;
  int? businessProfileId;
  String? type;
  String? name;
  String? discount;
  String? onOffer;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? description;
  int? viewCount;

  Datum({
    this.id,
    this.businessProfileId,
    this.type,
    this.name,
    this.discount,
    this.onOffer,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.description,
    this.viewCount,
  });

  Datum copyWith({
    int? id,
    int? businessProfileId,
    String? type,
    String? name,
    String? discount,
    String? onOffer,
    DateTime? startDate,
    DateTime? endDate,
    String? startTime,
    String? endTime,
    String? description,
    int? viewCount,
  }) =>
      Datum(
        id: id ?? this.id,
        businessProfileId: businessProfileId ?? this.businessProfileId,
        type: type ?? this.type,
        name: name ?? this.name,
        discount: discount ?? this.discount,
        onOffer: onOffer ?? this.onOffer,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        description: description ?? this.description,
        viewCount: viewCount ?? this.viewCount,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessProfileId: json["business_profile_id"],
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
        viewCount: json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_profile_id": businessProfileId,
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
        "view_count": viewCount,
      };
}
