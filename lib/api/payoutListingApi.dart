import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

Future payoutListingApi() async {
  var token = await getSharedPrefrence('token');

  final response = await http.get(
      Uri.parse(
        baseUrl + port2 + port + payout + requestList,
      ),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      });
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;

  }
  return convertDataToJson;
}
