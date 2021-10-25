import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/TotalSalesTabs/AvgOrderValue.dart';
import 'package:spicy_food_vendor/TotalSalesTabs/DeliveredOrders.dart';
import 'package:spicy_food_vendor/TotalSalesTabs/TotalSales_Tab.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class TotalSales extends StatefulWidget {
  @override
  _TotalSalesState createState() => _TotalSalesState();
}

class _TotalSalesState extends State<TotalSales> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Total Sales",
            style: HeadingTextStyle,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Delivered Order Trends"),
                  ),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: themeColor,
                    labelStyle: TabText,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2,
                        color: themeColor,
                      ),
                    ),
                    isScrollable: true,
                    // indicatorColor: themeRed,
                    unselectedLabelColor: Colors.grey,
                    onTap: (index) {
                      // Tab index when user select it, it start from zero
                    },
                    tabs: [
                      Tab(
                        text: "Delivered orders",
                      ),
                      Tab(
                        text: "Total sales",
                      ),
                      Tab(
                        text: "Average order value",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [DeliveredOrders(), TotSalesTab(), AvgSalesTab()],
        ),
      ),
    );
  }
}
