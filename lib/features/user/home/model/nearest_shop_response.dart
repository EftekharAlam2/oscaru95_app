import 'dart:convert';

class NearestShopResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  NearestShopResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  NearestShopResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      NearestShopResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory NearestShopResponse.fromRawJson(String str) =>
      NearestShopResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NearestShopResponse.fromJson(Map<String, dynamic> json) =>
      NearestShopResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        code: json["code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "success": success ?? false,
        "message": message ?? '',
        "data": data?.toJson(),
        "code": code ?? 0,
      };
}

class Data {
  List<LocationData> data;

  Data({
    required this.data,
  });

  Data copyWith({
    List<LocationData>? data,
  }) =>
      Data(
        data: data ?? this.data,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] != null
            ? List<LocationData>.from(
                json["data"].map((x) => LocationData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationData {
  int? id;
  String? venueName;
  String? type;
  String? openHour;
  String? closeHour;
  String? date;
  String? address;
  String? cover;
  String? distance;
  String? latitude;
  String? longitude;
  int? averageRating;
  int? totalReview;
  bool isWishlisted;

  LocationData({
    this.id,
    this.venueName,
    this.type,
    this.openHour,
    this.closeHour,
    this.date,
    this.address,
    this.cover,
    this.distance,
    this.latitude,
    this.longitude,
    this.averageRating,
    this.totalReview,
    this.isWishlisted = false,
  });

  LocationData copyWith({
    int? id,
    String? venueName,
    String? type,
    String? openHour,
    String? closeHour,
    String? date,
    String? address,
    String? cover,
    String? distance,
    String? latitude,
    String? longitude,
    int? averageRating,
    int? totalReview,
    bool? isWishlisted,
  }) =>
      LocationData(
        id: id ?? this.id,
        venueName: venueName ?? this.venueName,
        type: type ?? this.type,
        openHour: openHour ?? this.openHour,
        closeHour: closeHour ?? this.closeHour,
        date: date ?? this.date,
        address: address ?? this.address,
        cover: cover ?? this.cover,
        distance: distance ?? this.distance,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        averageRating: averageRating ?? this.averageRating,
        totalReview: totalReview ?? this.totalReview,
        isWishlisted: isWishlisted ?? this.isWishlisted,
      );

  factory LocationData.fromRawJson(String str) =>
      LocationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        id: json["id"],
        venueName: json["venue_name"] ?? '',
        type: json["type"] ?? '',
        openHour: json["open_hour"] ?? '',
        closeHour: json["close_hour"] ?? '',
        date: json["date"] ?? '',
        address: json["address"] ?? '',
        cover: json["cover"] ?? '',
        distance: json["distance"] ?? '',
        latitude: json["latitude"] ?? '',
        longitude: json["longitude"] ?? '',
        averageRating: json["average_rating"] ?? 0,
        totalReview: json["total_review"] ?? 0,
        isWishlisted: json["is_wishlisted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_name": venueName ?? '',
        "type": type ?? '',
        "open_hour": openHour ?? '',
        "close_hour": closeHour ?? '',
        "date": date ?? '',
        "address": address ?? '',
        "cover": cover ?? '',
        "distance": distance ?? '',
        "latitude": latitude ?? '',
        "longitude": longitude ?? '',
        "average_rating": averageRating ?? 0,
        "total_review": totalReview ?? 0,
        "is_wishlisted": isWishlisted,
      };
}
