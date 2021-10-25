import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

Future getProductsApi() async {
  var token = await getSharedPrefrence('token');
  print("tokennn");
  print(token);
  final response = await http.get(
      Uri.parse(
        baseUrl + port2 + port + products,
      ),
      headers: {"Authorization": "Bearer "+token.toString()});

  var convertDataToJson;


  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    print("convertDataToJsonnnnn");
    print(convertDataToJson);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
  }
  print(response.body);

  return convertDataToJson;
}
