import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

Future storeDetailApi() async {
  var token = await getSharedPrefrence('token');
  final response = await http.get(
      Uri.parse(
        baseUrl + port2 + port + storeDetail,
      ),
      headers: {"Authorization": "Bearer " + token});

  var convertDataToJson;
  var SortedData;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    SortedData = convertDataToJson["store"];
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
  }
  return SortedData;
}
