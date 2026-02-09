import 'dart:convert';

class UpdateProfileModel {
    bool? success;
    String? message;
    Data? data;
    int? code;

    UpdateProfileModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    UpdateProfileModel copyWith({
        bool? success,
        String? message,
        Data? data,
        int? code,
    }) => 
        UpdateProfileModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory UpdateProfileModel.fromRawJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
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
    String? fName;
    String? lName;
    String? email;
    String? phone;
    String? avatar;
    String? gender;
    DateTime? dob;
    String? zipCode;
    String? address;
    String? latitude;
    String? longitude;

    Data({
        this.fName,
        this.lName,
        this.email,
        this.phone,
        this.avatar,
        this.gender,
        this.dob,
        this.zipCode,
        this.address,
        this.latitude,
        this.longitude,
    });

    Data copyWith({
        String? fName,
        String? lName,
        String? email,
        String? phone,
        String? avatar,
        String? gender,
        DateTime? dob,
        String? zipCode,
        String? address,
        String? latitude,
        String? longitude,
    }) => 
        Data(
            fName: fName ?? this.fName,
            lName: lName ?? this.lName,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            avatar: avatar ?? this.avatar,
            gender: gender ?? this.gender,
            dob: dob ?? this.dob,
            zipCode: zipCode ?? this.zipCode,
            address: address ?? this.address,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        zipCode: json["zip_code"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "gender": gender,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "zip_code": zipCode,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
    };
}
