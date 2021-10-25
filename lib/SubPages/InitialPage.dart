import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/Widgets/BottomNav.dart';
import 'package:spicy_food_vendor/helper/common.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

import 'EnterNum.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {



  @override
  void initState() {
    super.initState();
    this._loadWidget();

  }


  void _loadWidget() async {



    var token = await getSharedPrefrence(Common.TOKEN);

    print("strId");
    print(token);
    if(token != null){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNav()),
      );
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/images/login.svg",
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Lorem ipsum dolor sit ame!",
                style: profileText,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Est ornare aliquam consectetur lacus",
                style: subTextStyle,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: Button2("Login", themeColor),
          height: 60,
        ));
  }

  Button2(String label, color) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EnterNumber()),
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: color),
          child: Text(
            label,
            style: whiteText,
          ),
        ),
      ),
    );
  }
}
