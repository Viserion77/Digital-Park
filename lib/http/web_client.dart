import 'dart:convert';

import 'package:http/http.dart';

Future postNewUser(userName, password) async {
  final Response response = await post(
    Uri.parse('http://192.168.100.27:3000/users'),
    headers: {
      "Authorization": "basic clientId:secret_forte_aqui_by_digital_park",
      "Content-Type": "application/json"
    },
    body: jsonEncode(
      {'userName': userName, 'password': password},
    ),
  );
  Map<String, dynamic> newUser = jsonDecode(response.body);
  return newUser;
}

Future<String> getOAuthToken(userName, password) async {
  final Response response = await post(
    Uri.parse('http://192.168.100.27:3000/oauth2/authorize'),
    headers: {
      "Authorization": "basic clientId:secret_forte_aqui_by_digital_park",
      "Content-Type": "application/json"
    },
    body: jsonEncode(
      {
        "userName": userName,
        "password": password,
        "scopes": ["normal-access"]
      },
    ),
  );
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  return responseJson["oAuthToken"];
}
