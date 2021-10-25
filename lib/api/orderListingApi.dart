import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/common.dart';
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

Future orderListingApi() async {
  var token = await getSharedPrefrence(Common.TOKEN);

  final response = await http.get(
      Uri.parse(
        baseUrl + port2 + port + portOrders + all,
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
  print(response.body);
  return convertDataToJson;
}
