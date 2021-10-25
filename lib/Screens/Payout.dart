import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/SubPages/TotalSales.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/Widgets/BottomNav.dart';
import 'package:spicy_food_vendor/api/payoutReqApi.dart';
import 'package:spicy_food_vendor/api/statusUpdationApi.dart';
import 'package:spicy_food_vendor/api/storeDetailApi.dart';
import 'package:spicy_food_vendor/api/storeEarningListApi.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

class Payout extends StatefulWidget {
  @override
  _PayoutState createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
  int _value = 1;
  var isLoading = true;
  var arrStoreDetails;
  var arrEarningDetails;
  bool isSwitched = false;

  @override
  void initState() {
    this.getDetails();
    this.getPayout();
    // this.getProducts();
    // timer = Timer.periodic(Duration(seconds: 10), (Timer t) =>NewBottomSheet());
  }

  Future<String> getDetails() async {
    var rsp = await storeDetailApi();
    print("rsppppppppppp");
    if (rsp != null) {
      setState(() {
        arrStoreDetails = rsp;

      });

    }


  }

  Future<String> getPayout() async {
    var rsp = await storeEarningListingApi();
    print("rsppppppppppp");
    if (rsp != null) {
      setState(() {
        arrEarningDetails = rsp;

      });

    }
    print(arrEarningDetails);

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              icon: Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.help_outline,
                  color: Colors.black,
                ),
              ),
              onPressed: () {}),
          IconButton(
              visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              icon: Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewOrders()),
                // );
              })
        ],
        title: Row(
          children: [
            CupertinoSwitch(
              value: arrStoreDetails!=null?arrStoreDetails["isOpen"]:false,
              onChanged: (value)async {
                if(arrStoreDetails["isOpen"] == true) {
                  var rsp = await statusApi(false);
                  if(rsp!=0){
                    setState(() {
                      arrStoreDetails["isOpen"] = false;
                    });
                  }

                } else{
                  var rsp = await statusApi(true);
                  if(rsp!=0){
                    setState(() {
                      arrStoreDetails["isOpen"] = true;
                    });
                  }
                }

              },
              activeColor: themeColor,
            ),
            Text(
              arrStoreDetails!=null?arrStoreDetails["isOpen"]==true?"Online":"Offline":"",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: (isLoading == true) ?
      Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.all(15),
          child: Wrap(
            runSpacing: 15,
            children: [
              DeliveredOrder(),
              CarouselSliderr(),
              DividerWidget,
              AvailableBlnc(),
             // DividerWidget,
              // RejectedOrders(),
              // CarouselSlider2(),
              // DividerWidget,
              // EarningsForToday()
            ],
          ),
        ),
      ),
    );
  }

  Widget DeliveredOrder() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
        children: [
          Text(
            "Delivered Orders ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNav()),
              );
            },
            child: Text(
              "See Orders",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 10,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Widget TodayBlueContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff3369FF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today",
              style: Text12,
            ),
            Text(
              rs + arrEarningDetails['today']['earning'].toString(),
              style: Text20White,
            ),
            Text(
              arrEarningDetails['today']['orderCount'].toString()+" Orders",
              style: Text12,
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last 7 Days",
                      style: Text12,
                    ),
                    Text(
                      rs + arrEarningDetails['sevenDays']['earning'].toString(),
                      style: Text20White,
                    ),
                    Text(
                      arrEarningDetails['sevenDays']['orderCount'].toString()+" Orders",
                      style: Text12,
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 0.5,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last 30 Days",
                      style: Text12,
                    ),
                    Text(
                      rs + arrEarningDetails['thirtyDays']['earning'].toString(),
                      style: Text20White,
                    ),
                    Text(
                      arrEarningDetails['thirtyDays']['orderCount'].toString()+" Orders",
                      style: Text12,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget TodayGreyContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF4F4F5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Earnings",
              style: Text12Grey,
            ),
            Text(
              rs + arrEarningDetails['totalEarning']['earning'].toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              arrEarningDetails['totalEarning']['orderCount'].toString()+" Orders",
              style: Text12Grey,
            ),
            // Divider(
            //   color: Colors.grey,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "This week: 01-07 Mar",
            //           style: Text12Grey,
            //         ),
            //         Text(
            //           rs + "0",
            //           style:
            //               TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            //         ),
            //         Text(
            //           "0 Orders",
            //           style: Text12Grey,
            //         ),
            //       ],
            //     ),
            //     Container(
            //       height: 50,
            //       width: 0.5,
            //       color: Colors.grey,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "This week: 01-07 Mar",
            //           style: Text12Grey,
            //         ),
            //         Text(
            //           rs + "0",
            //           style:
            //               TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            //         ),
            //         Text(
            //           "0 Orders",
            //           style: Text12Grey,
            //         ),
            //       ],
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget YestrdayBlueContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff3369FF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Seven Days",
              style: Text12,
            ),
            Text(
              rs + "0",
              style: Text20White,
            ),
            Text(
              "0 Orders",
              style: Text12,
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last week: 01-07 Mar",
                      style: Text12,
                    ),
                    Text(
                      rs + "0",
                      style: Text20White,
                    ),
                    Text(
                      "0 Orders",
                      style: Text12,
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 0.5,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last month: 01 - 28 Feb",
                      style: Text12,
                    ),
                    Text(
                      rs + "0",
                      style: Text20White,
                    ),
                    Text(
                      "0 Orders",
                      style: Text12,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget YestrdayGreyContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF4F4F5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Yesterday",
              style: Text12Grey,
            ),
            Text(
              rs + "0",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "0 Orders",
              style: Text12Grey,
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last week: 01-07 Mar",
                      style: Text12Grey,
                    ),
                    Text(
                      rs + "0",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "0 Orders",
                      style: Text12Grey,
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 0.5,
                  color: Colors.grey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last month: 01 - 28 Feb",
                      style: Text12Grey,
                    ),
                    Text(
                      rs + "0",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "0 Orders",
                      style: Text12Grey,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget CarouselSliderr() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        child: SizedBox(
          height: 178.0,
          child: Carousel(
            images: [TodayBlueContainer()
             , TodayGreyContainer()
            ],
            dotSize: 3.0,
            dotSpacing: 15.0,
            dotColor: Color(0xFFEF6862),
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            // animationDuration: Duration(seconds: 6),
            // boxFit: BoxFit.contain,
            // autoplay: ,
          ),
        ),
      ),
    );
  }

  Widget AvailableBlnc() {
    return Wrap(
      runSpacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                "Available Balance",
                style: profileText,
              ),
              Spacer(),
              Text(
                rs + arrEarningDetails['earning'].toString(),
                style: Text16,
              )
            ],
          ),
        ),
        Button2("Withdraw", Colors.green),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "My Earnings",
        //       style: greenText,
        //     ),
        //     Icon(
        //       Icons.arrow_forward_ios,
        //       size: 13,
        //       color: Colors.green,
        //     )
        //   ],
        // )
      ],
    );
  }

  Button2(String label, color) {
    return GestureDetector(
      onTap: ()async{
        var rsp = await payoutReqApi(arrEarningDetails['earning'].toString());
      },
      child: Padding(
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
      ),
    );
  }

  Widget RejectedOrders() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                "Rejected Orders ",
                style: Text15,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "See orders",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.blue,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget CarouselSlider2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        child: SizedBox(
          height: 160.0,
          child: Carousel(
            images: [TodayGreyContainer(), YestrdayGreyContainer()],
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.blue,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            // animationDuration: Duration(seconds: 6),
            // boxFit: BoxFit.contain,
            // autoplay: ,
          ),
        ),
      ),
    );
  }

  Widget EarningsForToday() {
    return Wrap(
      runSpacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Earnings For Today",
            style: boldTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                "Details from",
                style: subTextStyle,
              ),
              SizedBox(
                width: 5,
              ),
              DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  underline: SizedBox(),
                  // isExpanded: true,
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Today: 23 Feb",
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Second Item"),
                      value: 2,
                    ),
                    DropdownMenuItem(child: Text("Third Item"), value: 3),
                    DropdownMenuItem(child: Text("Fourth Item"), value: 4)
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
            ],
          ),
        ),
        Row(
          children: [Cont("Menu Items"), Cont("Revenue"), Cont("Quntity Sold")],
        )
      ],
    );
  }

  Widget Cont(String txt) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffF4F4F5),
            border: Border(right: BorderSide(width: 1, color: Colors.grey))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Text(
            txt,
            style: ProfileSmallText,
          ),
        ),
      ),
    );
  }
}
