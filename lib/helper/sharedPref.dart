import 'package:shared_preferences/shared_preferences.dart';

Future sharedPrefrence(key, data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);
}

Future getSharedPrefrence(key) async {
  var prefs = await SharedPreferences.getInstance();
  var value = prefs.getString(key);

  return value;
}
