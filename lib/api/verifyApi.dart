import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spicy_food_vendor/helper/network.dart';

Future verifyOtpApi(otp, num) async {
  final response = await http.post(
    Uri.parse(
      baseUrl + port2 + port + enterOtp,
    ),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(<String, String>{
      'otp': otp.toString(),
      'phoneCode': "+91",
      'phoneNumber': num.toString(),
    }),
  );
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
