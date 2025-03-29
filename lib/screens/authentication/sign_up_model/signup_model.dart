// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    String? message;
    String? role;
    Data? data;

    LoginResponse({
        this.message,
        this.role,
        this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        role: json["role"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "role": role,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? fullname;
    String? password;
    String? email;
    dynamic profile;

    Data({
        this.id,
        this.fullname,
        this.password,
        this.email,
        this.profile,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullname: json["fullname"],
        password: json["password"],
        email: json["email"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "password": password,
        "email": email,
        "profile": profile,
    };
}
