import 'dart:convert';
import 'dart:io';

import '../../../url/json_url.dart';
import '../register_grievance_model/register_grievance_model.dart';
import 'package:http/http.dart' as http;

Future<ComplaintRegisterModel> complaintregister({
  // required int id,
  required String name,
  required String phone,
  required String email,
  required String address,
  required String city,
  required String latitude,
  required String longitude,
  required String photo,
  required String description,
  required String date,
  required String aadhaarPhoto,
  required int category,
  required int userId,
}) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(compalintReg),
    );

    // Add fields to the request
    //  request.fields['id'] = id.toString();
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['email'] = email;
    request.fields['address'] = address;
    request.fields['city'] = city;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['description'] = description;
    request.fields['date_of_incident'] = date;
    request.fields['category'] = category.toString();
    request.fields['user'] = userId.toString();

    // Add files to the request
    if (photo.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('photo', photo));
    }
    if (aadhaarPhoto.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('aadhaar_photo', aadhaarPhoto));
    }

    // Send the request
    var response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> decoded = jsonDecode(responseBody);
      
      return ComplaintRegisterModel.fromJson(decoded);
    } else {
      throw Exception('Failed to load response ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('Server error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad request');
  } catch (e) {
    throw Exception(e.toString());
  }
}
