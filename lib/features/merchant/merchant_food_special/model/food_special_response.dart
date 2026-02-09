import 'dart:convert';

class FoodSpecialResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  FoodSpecialResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  FoodSpecialResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    int? code,
  }) =>
      FoodSpecialResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory FoodSpecialResponse.fromRawJson(String str) =>
      FoodSpecialResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FoodSpecialResponse.fromJson(Map<String, dynamic> json) =>
      FoodSpecialResponse(
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
  String? type;
  String? fromDay;
  String? toDay;
  String? fromTime;
  String? toTime;
  List<ItemList>? itemList;

  Datum({
    this.id,
    this.title,
    this.type,
    this.fromDay,
    this.toDay,
    this.fromTime,
    this.toTime,
    this.itemList,
  });

  Datum copyWith({
    int? id,
    String? title,
    String? type,
    String? fromDay,
    String? toDay,
    String? fromTime,
    String? toTime,
    List<ItemList>? itemList,
  }) =>
      Datum(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        fromDay: fromDay ?? this.fromDay,
        toDay: toDay ?? this.toDay,
        fromTime: fromTime ?? this.fromTime,
        toTime: toTime ?? this.toTime,
        itemList: itemList ?? this.itemList,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        fromDay: json["from_day"],
        toDay: json["to_day"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        itemList: json["item_list"] == null
            ? []
            : List<ItemList>.from(
                json["item_list"]!.map((x) => ItemList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "from_day": fromDay,
        "to_day": toDay,
        "from_time": fromTime,
        "to_time": toTime,
        "item_list": itemList == null
            ? []
            : List<dynamic>.from(itemList!.map((x) => x.toJson())),
      };
}

class ItemList {
  int? id;
  String? name;
  String? regularPrice;
  String? offerPrice;
  String? ingredients;

  ItemList({
    this.id,
    this.name,
    this.regularPrice,
    this.offerPrice,
    this.ingredients,
  });

  ItemList copyWith({
    int? id,
    String? name,
    String? regularPrice,
    String? offerPrice,
    String? ingredients,
  }) =>
      ItemList(
        id: id ?? this.id,
        name: name ?? this.name,
        regularPrice: regularPrice ?? this.regularPrice,
        offerPrice: offerPrice ?? this.offerPrice,
        ingredients: ingredients ?? this.ingredients,
      );

  factory ItemList.fromRawJson(String str) =>
      ItemList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        id: json["id"],
        name: json["name"],
        regularPrice: json["regular_price"],
        offerPrice: json["offer_price"],
        ingredients: json["ingredients"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "regular_price": regularPrice,
        "offer_price": offerPrice,
        "ingredients": ingredients,
      };
}
