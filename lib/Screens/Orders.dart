import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:spicy_food_vendor/OrderFragment/new.dart';
import 'package:spicy_food_vendor/OrderFragment/perpairing.dart';
import 'package:spicy_food_vendor/OrderFragment/ready.dart';
import 'package:spicy_food_vendor/SubPages/Notifications.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/api/statusUpdationApi.dart';
import 'package:spicy_food_vendor/api/storeDetailApi.dart';
import 'package:spicy_food_vendor/helper/sharedPref.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var isLoading = true;
  var arrStoreDetails;
  List<dynamic> arrProdList = [];
  List<dynamic> arrList = [];

  Timer timer;
  final GlobalKey<SlideActionState> _key = GlobalKey();
  var checked = "NEW";
  var isTap = false;

  @override
  void initState() {
    this.getDetails();
    // this.getProducts();
    // timer = Timer.periodic(Duration(seconds: 10), (Timer t) =>NewBottomSheet());
  }

  Future<String> getDetails() async {
    var rsp = await storeDetailApi();
    print("rsppppppppppp");
    if (rsp != null) {
      arrStoreDetails = rsp;
      var token = await getSharedPrefrence('token');
      print("token");
      print(token);
      print("token");
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              CupertinoSwitch(
                value:
                    arrStoreDetails != null ? arrStoreDetails["isOpen"] : false,
                onChanged: (value) async {
                  if (arrStoreDetails["isOpen"] == true) {
                    var rsp = await statusApi(false);
                    if (rsp != 0) {
                      setState(() {
                        arrStoreDetails["isOpen"] = false;
                      });
                    }
                  } else {
                    var rsp = await statusApi(true);
                    if (rsp != 0) {
                      setState(() {
                        arrStoreDetails["isOpen"] = true;
                      });
                    }
                  }
                },
                activeColor: themeColor,
              ),
              Text(
                arrStoreDetails != null
                    ? arrStoreDetails["isOpen"] == true
                        ? "Online"
                        : "Offline"
                    : "",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.white,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()),
                  );
                })
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Column(
            children: [
              _tabSection(context),
              // Divider(),
              //
              // (isTap == true) ?
              // Center(child: CircularProgressIndicator())
              //     :OrderDetailsListView(),
              Divider(),
            ],
          )),
        ));
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                ),
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "New",
                    ),
                    Tab(text: "Preparing"),
                    Tab(text: "Ready"),
                  ],
                  indicatorColor: Colors.red,
                  indicator: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  unselectedLabelColor: themeColor,

                  automaticIndicatorColorAdjustment: true,
                  //labelStyle: bold14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    NewOrder(),
                    PrepairingOrder(),
                    ReadyOrder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
