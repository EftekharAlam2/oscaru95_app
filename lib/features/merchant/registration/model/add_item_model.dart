import 'dart:convert';

class DrinkItem {
  int? categoryId;
  String? type;
  List<ItemList>? itemLists;
  List<ItemHour>? itemHours;

  DrinkItem({
    this.categoryId,
    this.type,
    this.itemLists,
    this.itemHours,
  });

  DrinkItem copyWith({
    int? categoryId,
    String? type,
    List<ItemList>? itemLists,
    List<ItemHour>? itemHours,
  }) =>
      DrinkItem(
        categoryId: categoryId ?? this.categoryId,
        type: type ?? this.type,
        itemLists: itemLists ?? this.itemLists,
        itemHours: itemHours ?? this.itemHours,
      );

  factory DrinkItem.fromRawJson(String str) =>
      DrinkItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrinkItem.fromJson(Map<String, dynamic> json) => DrinkItem(
        categoryId: json["category_id"],
        type: json["type"],
        itemLists: json["item_lists"] == null
            ? []
            : List<ItemList>.from(
                json["item_lists"]!.map((x) => ItemList.fromJson(x))),
        itemHours: json["item_hours"] == null
            ? []
            : List<ItemHour>.from(
                json["item_hours"]!.map((x) => ItemHour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "type": type,
        "item_lists": itemLists == null
            ? []
            : List<dynamic>.from(itemLists!.map((x) => x.toJson())),
        "item_hours": itemHours == null
            ? []
            : List<dynamic>.from(itemHours!.map((x) => x.toJson())),
      };
}

class ItemHour {
  String? day;
  bool? isClosed;
  String? openTime;
  String? closeTime;

  ItemHour({
    this.day,
    this.isClosed,
    this.openTime,
    this.closeTime,
  });

  ItemHour copyWith({
    String? day,
    bool? isClosed,
    String? openTime,
    String? closeTime,
  }) =>
      ItemHour(
        day: day ?? this.day,
        isClosed: isClosed ?? this.isClosed,
        openTime: openTime ?? this.openTime,
        closeTime: closeTime ?? this.closeTime,
      );

  factory ItemHour.fromRawJson(String str) =>
      ItemHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemHour.fromJson(Map<String, dynamic> json) => ItemHour(
        day: json["day"],
        isClosed: json["is_closed"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "is_closed": isClosed,
        "open_time": openTime,
        "close_time": closeTime,
      };
}

class ItemList {
  int? cuisineId;
  String? name;
  double? regularPrice;
  double? offerPrice;
  String? ingredients;

  ItemList({
    this.cuisineId,
    this.name,
    this.regularPrice,
    this.offerPrice,
    this.ingredients,
  });

  ItemList copyWith({
    int? cuisineId,
    String? name,
    double? regularPrice,
    double? offerPrice,
    String? ingredients,
  }) =>
      ItemList(
        cuisineId: cuisineId ?? this.cuisineId,
        name: name ?? this.name,
        regularPrice: regularPrice ?? this.regularPrice,
        offerPrice: offerPrice ?? this.offerPrice,
        ingredients: ingredients ?? this.ingredients,
      );

  factory ItemList.fromRawJson(String str) =>
      ItemList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        cuisineId: json["cuisine_id"],
        name: json["name"],
        regularPrice: json["regular_price"]?.toDouble(),
        offerPrice: json["offer_price"]?.toDouble(),
        ingredients: json["ingredients"],
      );

  Map<String, dynamic> toJson() => {
        "cuisine_id": cuisineId,
        "name": name,
        "regular_price": regularPrice,
        "offer_price": offerPrice,
        "ingredients": ingredients,
      };
}
