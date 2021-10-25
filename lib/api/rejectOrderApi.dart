import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';
import 'package:spicy_food_vendor/helper/snackbar_toast_helper.dart';

Future rejectOrderApi(orderNum) async {
  var token = await getSharedPrefrence('token');

  final response = await http.post(Uri.parse(baseUrl + port2 + port + port3 + reject,),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + token},
      body: jsonEncode(<String, String>{
      'orderNo': orderNum.toString()}),
      );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);

    showToastSuccess("Order Status Updated!");
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    var message = json.decode(response.body);
    showToastSuccess(message['message'].toString());
    print("response.bodyyyyyyy");
    print(response.body);

  }
  return convertDataToJson;
}
