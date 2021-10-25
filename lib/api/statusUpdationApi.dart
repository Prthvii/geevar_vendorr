import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/common.dart';
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';
import 'package:spicy_food_vendor/helper/snackbar_toast_helper.dart';




Future statusApi(stat) async {

  var token = await getSharedPrefrence(Common.TOKEN);
    Map<String, String> queryParameters = {

    'isOpen': stat.toString(),
    };

  String queryString = Uri(queryParameters: queryParameters).query;

  final response = await http.get(
    baseUrl+port2+port+status+ '?' + queryString,
    headers: {"Content-Type": "application/json","Authorization": "Bearer "+token}

  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = stat.toString();



    // If the server did return a 200 OK response,
    // then parse the JSON.

    showToastSuccess("Status updated!");

  } else {
    convertDataToJson = null;
        print("response.body");
        print(response.body);
    showToastSuccess("Something went wrong! Check your internet connection");
  }
  return convertDataToJson;
}