import 'dart:convert';

class ReviewResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  ReviewResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  ReviewResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) =>
      ReviewResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory ReviewResponse.fromRawJson(String str) =>
      ReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
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
  String? userName;
  String? userAvatar;
  String? categoryName;
  int? rating;
  String? comment;
  String? createdAt;

  Datum({
    this.id,
    this.userName,
    this.userAvatar,
    this.categoryName,
    this.rating,
    this.comment,
    this.createdAt,
  });

  Datum copyWith({
    int? id,
    String? userName,
    String? userAvatar,
    String? categoryName,
    int? rating,
    String? comment,
    String? createdAt,
  }) =>
      Datum(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        userAvatar: userAvatar ?? this.userAvatar,
        categoryName: categoryName ?? this.categoryName,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userName: json["user_name"],
        userAvatar: json["user_avatar"],
        categoryName: json["category_name"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "user_avatar": userAvatar,
        "category_name": categoryName,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt,
      };
}
