import 'dart:io';

import '../../../url/json_url.dart';
import '../sign_up_model/signup_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<LoginResponse> userSignin(
    {required int id,
    required String fullname,
    required String password,
    required String email,
    required String role}) async {
  // print("Before calling userSignin");
  try {
    final resp = await http.post(Uri.parse(userSignUp),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "fullname": fullname,
          "password": password,
          "email": email,
          "role": role
        }));
    print(resp);
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      print(resp.body);
      print(resp.statusCode);
      var jsonData = jsonDecode(resp.body);
      String? message = jsonData["message"];
      if (jsonData.containsKey('data')) {
        return LoginResponse.fromJson(jsonData)..message = message;
      } else {
        throw Exception(message ?? 'Unknown error occurred.');
      }
    } else {
      throw Exception('Failed to sign in: ${resp.statusCode}');
    }
  } on SocketException {
    throw Exception('No Internet connection');
  } on HttpException {
    throw Exception('Server error');
  } on FormatException {
    throw Exception('Bad response format');
  } catch (e) {
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
