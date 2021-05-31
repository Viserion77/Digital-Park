import 'dart:convert';

import 'package:http/http.dart';

Future postNewUser(userName, password, email) async {
  final Response response = await post(
    Uri.parse('http://localhost:4000/api/v1/users/register'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      {'username': userName, 'password': password, 'email': email},
    ),
  );
  Map<String, dynamic> newUser = jsonDecode(response.body);
  return newUser;
}

Future<String> getOAuthToken(userName, password) async {
  final Response response = await post(
    Uri.parse('http://localhost:4000/api/v1/users/auth'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      {
        "username": userName,
        "password": password,
      },
    ),
  );
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  return responseJson["oAuthToken"];
}
