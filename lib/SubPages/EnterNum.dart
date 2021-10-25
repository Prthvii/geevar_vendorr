import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/Widgets/BottomNav.dart';
import 'package:spicy_food_vendor/api/loginApi.dart';
import 'package:spicy_food_vendor/api/verifyApi.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';
import 'package:spicy_food_vendor/helper/snackbar_toast_helper.dart';

class EnterNumber extends StatefulWidget {
  @override
  _EnterNumberState createState() => _EnterNumberState();
}

class _EnterNumberState extends State<EnterNumber> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _edtMobileController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();
  ScrollController _scrollController;
  bool isButtonEnabled = false;
  var _isVisible;
  var isTaped = false;
  Animation<double> animation;
  AnimationController controller;

  bool isEmpty() {
    setState(() {
      if (_edtMobileController.text.length == 10) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
    return isButtonEnabled;
  }

  void onTaped() {
    setState(() {
      isTaped = true;
    });
  }

  void onTapedDisable() {
    setState(() {
      isTaped = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.stop();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By continuing you confirms that you agree with \n our ',
              style: TextStyle(fontSize: 13, color: Colors.grey[400]),
              children: [
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      fontSize: 13,
                      color: themeColor),
                )
              ]),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  "Continue with phone number",
                  style: HeadingTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Enter your phone number to proceed ",
                  style: subTextStyle,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Phone number",
                  style: subTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  controller: _edtMobileController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onSubmitted: null,
                  onChanged: (val) {
                    setState(() {
                      isEmpty();
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Text(
                      "+91 ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                isTaped
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          LinearProgressIndicator(
                            minHeight: 45,
                            // value: animation.value,
                            backgroundColor: Colors.red[100],
                            semanticsLabel: "Sending...",
                            semanticsValue: "Sending...",
                          ),
                          Text(
                            "Wait a movement",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: isButtonEnabled
                            ? () async {
                                if (_edtMobileController.text != null) {
                                  onTaped();
                                  var rsp = await enterNumberApi(
                                      _edtMobileController.text);
                                  print("rsppppppp");
                                  print(rsp);
                                  if (rsp != 0) {
                                    NewBottomSheet();
                                  } else {
                                    // showToastSuccess(
                                    //     "Something went wrong! Check your internet connection");
                                  }
                                } else {
                                  customSnackBar(
                                      context,
                                      "Please use 10 times '9's",
                                      "Try again",
                                      _scaffoldKey,
                                      2);
                                }
                                // NewBottomSheet();
                                onTapedDisable();
                              }
                            : null,
                        child: Button2("Send OTP", themeColor),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Button2(String label, color) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            label,
            style: whiteText,
          ),
        ),
      ),
    );
  }

  NewBottomSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) => Stack(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Enter OTP to login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ),
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Verify OTP",
                        style: TextStyle(
                            color: themeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      Text("OTP sent to " +
                          _edtMobileController.text.toString()),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      OTP(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            onTaped();

                            var rsp = await verifyOtpApi(
                                _otpController.text, _edtMobileController.text);
                            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~`");
                            print(rsp);
                            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~`");

                            if (rsp == 0) {
                              showToastSuccess(
                                  "Something went wrong! Check your internet connection");
                              onTapedDisable();
                            } else if (rsp['message'].toString() ==
                                "OTP Verified") {
                              var token =
                                  await sharedPrefrence("token", rsp['token']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNav()),
                              );
                            } else {
                              onTapedDisable();
                            }

                            print("responsee");
                            print(rsp);
                          },
                          child: Button2("Submit", themeColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            top: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }

  OTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter OTP ",
          textAlign: TextAlign.start,
        ),
        PinCodeTextField(
          appContext: context,
          length: 6,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          // validator: (v) {},
          pinTheme: PinTheme(
            inactiveFillColor: Colors.white,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white,
            borderWidth: 2,
            activeColor: themeColor,
            inactiveColor: themeColor,
            selectedColor: themeColor,
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 40,
            fieldWidth: 40,
          ),
          cursorColor: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          enableActiveFill: true,
          controller: _otpController,
          autoFocus: false,
          keyboardType: TextInputType.number,

          onCompleted: (v) {
            // print("Completed");
          },
          onChanged: (value) {},
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 10),
        ),
      ],
    );
  }
}
