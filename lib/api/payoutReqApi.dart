import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';
import 'package:spicy_food_vendor/helper/snackbar_toast_helper.dart';

Future payoutReqApi(amount) async {
  var token = await getSharedPrefrence('token');

  final response = await http.post(Uri.parse(baseUrl + port2 + port + payout+request,),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + token},
      body: jsonEncode(<String, String>{
      'amount': amount.toString()}),
      );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    var msg = json.decode(response.body);
    showToastSuccess(msg['message'].toString());
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    convertDataToJson = 0;
    var msg = json.decode(response.body);
    showToastSuccess(msg['message'].toString());
  }
  return convertDataToJson;
}
