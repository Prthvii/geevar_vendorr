import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

Future sendNotiTokenApi(token1) async {

  var token = await getSharedPrefrence('token');

  final response = await http.post(
    Uri.parse(
      baseUrl + port2 + port + notification,
    ),
    headers: {"Content-Type": "application/json",   "Authorization": "Bearer " + token},
    body: jsonEncode(<String, String>{
      'token': token1.toString(), }),
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = "Something went wrong! :(";
    print(response.body);
  }

  return convertDataToJson;
  print(response.body);
}
