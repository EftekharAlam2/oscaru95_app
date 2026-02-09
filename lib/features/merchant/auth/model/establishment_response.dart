import 'dart:convert';

class EstablishmentResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  EstablishmentResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  EstablishmentResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) =>
      EstablishmentResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory EstablishmentResponse.fromRawJson(String str) =>
      EstablishmentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstablishmentResponse.fromJson(Map<String, dynamic> json) =>
      EstablishmentResponse(
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
  String? title;

  Datum({
    this.id,
    this.title,
  });

  Datum copyWith({
    int? id,
    String? title,
  }) =>
      Datum(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
