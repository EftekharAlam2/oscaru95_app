import 'dart:convert';

class AddItemModel {
    bool? success;
    String? message;
    Data? data;
    int? code;

    AddItemModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    AddItemModel copyWith({
        bool? success,
        String? message,
        Data? data,
        int? code,
    }) => 
        AddItemModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory AddItemModel.fromRawJson(String str) => AddItemModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddItemModel.fromJson(Map<String, dynamic> json) => AddItemModel(
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
    Item? item;
    List<ItemList>? itemLists;
    List<ItemHour>? itemHours;

    Data({
        this.item,
        this.itemLists,
        this.itemHours,
    });

    Data copyWith({
        Item? item,
        List<ItemList>? itemLists,
        List<ItemHour>? itemHours,
    }) => 
        Data(
            item: item ?? this.item,
            itemLists: itemLists ?? this.itemLists,
            itemHours: itemHours ?? this.itemHours,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        itemLists: json["item_lists"] == null ? [] : List<ItemList>.from(json["item_lists"]!.map((x) => ItemList.fromJson(x))),
        itemHours: json["item_hours"] == null ? [] : List<ItemHour>.from(json["item_hours"]!.map((x) => ItemHour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item": item?.toJson(),
        "item_lists": itemLists == null ? [] : List<dynamic>.from(itemLists!.map((x) => x.toJson())),
        "item_hours": itemHours == null ? [] : List<dynamic>.from(itemHours!.map((x) => x.toJson())),
    };
}

class Item {
    int? id;
    int? businessProfileId;
    int? categoryId;
    String? type;

    Item({
        this.id,
        this.businessProfileId,
        this.categoryId,
        this.type,
    });

    Item copyWith({
        int? id,
        int? businessProfileId,
        int? categoryId,
        String? type,
    }) => 
        Item(
            id: id ?? this.id,
            businessProfileId: businessProfileId ?? this.businessProfileId,
            categoryId: categoryId ?? this.categoryId,
            type: type ?? this.type,
        );

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        businessProfileId: json["business_profile_id"],
        categoryId: json["category_id"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "business_profile_id": businessProfileId,
        "category_id": categoryId,
        "type": type,
    };
}

class ItemHour {
    int? id;
    int? itemId;
    String? day;
    int? isClosed;
    String? openTime;
    String? closeTime;

    ItemHour({
        this.id,
        this.itemId,
        this.day,
        this.isClosed,
        this.openTime,
        this.closeTime,
    });

    ItemHour copyWith({
        int? id,
        int? itemId,
        String? day,
        int? isClosed,
        String? openTime,
        String? closeTime,
    }) => 
        ItemHour(
            id: id ?? this.id,
            itemId: itemId ?? this.itemId,
            day: day ?? this.day,
            isClosed: isClosed ?? this.isClosed,
            openTime: openTime ?? this.openTime,
            closeTime: closeTime ?? this.closeTime,
        );

    factory ItemHour.fromRawJson(String str) => ItemHour.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemHour.fromJson(Map<String, dynamic> json) => ItemHour(
        id: json["id"],
        itemId: json["item_id"],
        day: json["day"],
        isClosed: json["is_closed"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "day": day,
        "is_closed": isClosed,
        "open_time": openTime,
        "close_time": closeTime,
    };
}

class ItemList {
    int? id;
    int? itemId;
    int? cuisineId;
    String? name;
    String? regularPrice;
    String? offerPrice;
    String? ingredients;

    ItemList({
        this.id,
        this.itemId,
        this.cuisineId,
        this.name,
        this.regularPrice,
        this.offerPrice,
        this.ingredients,
    });

    ItemList copyWith({
        int? id,
        int? itemId,
        int? cuisineId,
        String? name,
        String? regularPrice,
        String? offerPrice,
        String? ingredients,
    }) => 
        ItemList(
            id: id ?? this.id,
            itemId: itemId ?? this.itemId,
            cuisineId: cuisineId ?? this.cuisineId,
            name: name ?? this.name,
            regularPrice: regularPrice ?? this.regularPrice,
            offerPrice: offerPrice ?? this.offerPrice,
            ingredients: ingredients ?? this.ingredients,
        );

    factory ItemList.fromRawJson(String str) => ItemList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        id: json["id"],
        itemId: json["item_id"],
        cuisineId: json["cuisine_id"],
        name: json["name"],
        regularPrice: json["regular_price"],
        offerPrice: json["offer_price"],
        ingredients: json["ingredients"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "cuisine_id": cuisineId,
        "name": name,
        "regular_price": regularPrice,
        "offer_price": offerPrice,
        "ingredients": ingredients,
    };
}
