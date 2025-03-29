import 'dart:convert';
import 'dart:io';
import '../../../url/json_url.dart';
import '../login_model/login_model_page.dart';
import 'package:http/http.dart' as http;

Future<OnlineComplaintRegisterModel> loginUser({
  required String password,
  required String email,
  required int id,
  // required String message,
  required String role,
  // required String username,
}) async {
  try {
    final Map<String, dynamic> body = {
      "id": id,
      "email": email,
      "password": password,
      "role": role
    };
    final res = await http.post(Uri.parse(userLogin),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    print(body);
    print(res);
    print(res.body);

    if (res.statusCode == 200) {
      final dynamic decoded = jsonDecode(res.body);
      final response = OnlineComplaintRegisterModel.fromJson(decoded);
      print(decoded['id']);

      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(res.body);
      throw Exception(
        'Failed to login: ${errorResponse['message'] ?? 'Unknown error'}',
      );
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
