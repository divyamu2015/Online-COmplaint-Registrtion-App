// To parse this JSON data, do
//
//     final complaintRegisterModel = complaintRegisterModelFromJson(jsonString);

import 'dart:convert';

ComplaintRegisterModel complaintRegisterModelFromJson(String str) => ComplaintRegisterModel.fromJson(json.decode(str));

String complaintRegisterModelToJson(ComplaintRegisterModel data) => json.encode(data.toJson());

class ComplaintRegisterModel {
    String? name;
    String? email;
    String? phone;
    String? address;
    String? city;
    String? latitude;
    String? longitude;
    dynamic photo;
    String? description;
    String? statusCode;
    dynamic aadhaarPhoto;
    DateTime? dateOfIncident;
    dynamic proofOfWork;
    int? user;
    dynamic category;
    dynamic assignedOfficer;

    ComplaintRegisterModel({
        this.name,
        this.email,
        this.phone,
        this.address,
        this.city,
        this.latitude,
        this.longitude,
        this.photo,
        this.description,
        this.statusCode,
        this.aadhaarPhoto,
        this.dateOfIncident,
        this.proofOfWork,
        this.user,
        this.category,
        this.assignedOfficer,
    });

    factory ComplaintRegisterModel.fromJson(Map<String, dynamic> json) => ComplaintRegisterModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        photo: json["photo"],
        description: json["description"],
        statusCode: json["status_code"],
        aadhaarPhoto: json["aadhaar_photo"],
        dateOfIncident: json["date_of_incident"] == null ? null : DateTime.parse(json["date_of_incident"]),
        proofOfWork: json["proof_of_work"],
        user: json["user"],
        category: json["category"],
        assignedOfficer: json["assigned_officer"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
        "photo": photo,
        "description": description,
        "status_code": statusCode,
        "aadhaar_photo": aadhaarPhoto,
        "date_of_incident": "${dateOfIncident!.year.toString().padLeft(4, '0')}-${dateOfIncident!.month.toString().padLeft(2, '0')}-${dateOfIncident!.day.toString().padLeft(2, '0')}",
        "proof_of_work": proofOfWork,
        "user": user,
        "category": category,
        "assigned_officer": assignedOfficer,
    };
}
