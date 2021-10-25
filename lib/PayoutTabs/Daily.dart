import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class DailyTab extends StatefulWidget {
  @override
  _DailyTabState createState() => _DailyTabState();
}

class _DailyTabState extends State<DailyTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            PerformanceToday(),
            TripsLoginTouchPoints(),
            VideoWidget(),
            EarningForTodaySection(),
          ],
        ),
      ),
    );
  }

  PerformanceToday() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            " Performance for today",
            style: HeadingTextStyle,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Text(
                    "See trips",
                    style: blueText,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: themeColor,
                    size: 18,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TripsLoginTouchPoints() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                    Text(
                      "Trips",
                      style: subTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      // alignment: Alignment.center,
                      // width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          "0.0",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                    Text(
                      "Login hours",
                      style: subTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                    Text(
                      "Touchpoints",
                      style: subTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  VideoWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: themeColor),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tips to earn more",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Watch these training videos and earn more",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Watch Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Image(
                    image: AssetImage("assets/images/play.png"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  EarningForTodaySection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EarningsToday(),
            OrderPay(),
          ],
        ),
      ),
    );
  }

  EarningsToday() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Earnings for today",
                    style: HeadingTextStyle,
                  ),
                  Spacer(),
                  Text(
                    rs + "40",
                    style: HeadingTextStyle,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Earnings for last tuesday",
                    style: subTextStyle,
                  ),
                  Spacer(),
                  Text(
                    rs + "40",
                    style: subTextStyle,
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ));
  }

  OrderPay() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow[600],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Pay",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Earnings per day",
                          style: subTextStyle,
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(rs + "40",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Target Pay",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "For reaching touchpoint targets",
                          style: subTextStyle,
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(rs + "40",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
