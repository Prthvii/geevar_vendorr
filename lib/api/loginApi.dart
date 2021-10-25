import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';
import 'package:spicy_food_vendor/helper/snackbar_toast_helper.dart';

Future enterNumberApi(num) async {
  final response = await http.post(
    Uri.parse(
      baseUrl + port2 + port + enterNum,
    ),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(<String, String>{
      'phoneCode': "+91",
     'phoneNumber': num.toString()}),
  );
  var convertDataToJson;

  if (response.statusCode == 200) {
    convertDataToJson = json.decode(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    var msg = json.decode(response.body);
    showToastSuccess(
        msg['message'].toString());
    convertDataToJson = 0;
    print(response.body);
  }

  return convertDataToJson;
}
