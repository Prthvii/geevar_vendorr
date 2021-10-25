import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class Ready extends StatefulWidget {
  @override
  _ReadyState createState() => _ReadyState();
}

class _ReadyState extends State<Ready> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeColor: themeColor,
              ),
              Text(
                "Online",
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
                onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Column(
            children: [
              OrderStatusTabs(),
              Divider(),
              OrderDetailsListView(),
              Divider(),
            ],
          )),
        ));
  }

  OrderDetailsListView() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => DividerWidget,
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return OrderDetails(index);
      },
    );
  }

  OrderDetails(int index) {
    return Container(
      child: Column(
        children: [
          OrderIdDetails(),
          OrderItem(),
          Divider(),
          TotalBill(),
          OrderReadyWidget()
        ],
      ),
    );
  }

  OrderStatusTabs() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Text(
                  "Preparing(3)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Text(
                  "Ready(3)",
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Text(
                  "Picked Up(1)",
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OrderIdDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "ID: 123456789",
                style: subText,
              ),
              Spacer(),
              Text(
                "6:30 PM",
                style: subTextStyle,
              ),
              IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {})
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Ready",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Aron's 5th order",
                style: greenText,
              )
            ],
          ),
        ],
      ),
    );
  }

  OrderItem() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return OrderItemDetails(index);
      },
    );
  }

  OrderItemDetails(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "1x",
            style: subText,
          ),
          Text(
            "McAloo Tikki + Fries (M)",
            style: subText,
          ),
          Spacer(),
          Text(
            rs + "250",
            style: subText,
          )
        ],
      ),
    );
  }

  TotalBill() {
    return ExpansionTile(
      title: Row(
        children: [
          Text(
            "Total bill : " + rs + "500",
            style: subTextStyle,
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "PAID",
                style: TextStyle(color: Colors.grey[500], fontSize: 10),
              ),
            ),
            color: Colors.grey[200],
          )
        ],
      ),
      children: [Text("aaaa")],
    );
  }

  OrderReadyWidget() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: themeColor, borderRadius: BorderRadius.circular(10)),
      child: Text(
        "Pickup (OTP : 5398)",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
