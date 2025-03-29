// To parse this JSON data, do
//
//     final onlineComplaintRegisterModel = onlineComplaintRegisterModelFromJson(jsonString);

import 'dart:convert';

OnlineComplaintRegisterModel onlineComplaintRegisterModelFromJson(String str) => OnlineComplaintRegisterModel.fromJson(json.decode(str));

String onlineComplaintRegisterModelToJson(OnlineComplaintRegisterModel data) => json.encode(data.toJson());

class OnlineComplaintRegisterModel {
    String message;
    int id;
    String role;
    String email;
    String password;
    String username;

    OnlineComplaintRegisterModel({
        required this.message,
        required this.id,
        required this.role,
        required this.email,
        required this.password,
        required this.username,
    });

    factory OnlineComplaintRegisterModel.fromJson(Map<String, dynamic> json) => OnlineComplaintRegisterModel(
        message: json["message"],
        id: json["id"],
        role: json["role"],
        email: json["email"],
        password: json["password"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "role": role,
        "email": email,
        "password": password,
        "username": username,
    };
}
