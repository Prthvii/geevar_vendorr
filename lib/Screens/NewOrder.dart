import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class NewOrders extends StatefulWidget {
  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              NewBottomSheet();
            },
            child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("New Order"),
                )),
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
        isScrollControlled: true,
        builder: (context) => Wrap(children: [
              Stack(children: [
                Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.blue,
                              size: 15,
                            ),
                            Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                    )),
                Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/newOrder.png")))),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "New Order!",
                      style: boldTextStyle,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Expected earning",
                                    style: subTextStyle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    rs + "500",
                                    style: HeadingTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 2,
                            color: Colors.grey[300],
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Trip Distance",
                                    style: subTextStyle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    rs + "500",
                                    style: HeadingTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order items",
                                style: HeadingTextStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 5,
                                  ),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return FoodItems(index);
                                  },
                                  itemCount: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SlideAction(
                      height: 50,
                      key: _key,
                      onSubmit: () {
                        Future.delayed(
                          Duration(seconds: 1),
                          () => _key.currentState.reset(),
                        );
                      },
                      innerColor: Colors.green,
                      borderRadius: 1,
                      sliderButtonIconPadding: 1,
                      elevation: 0,
                      outerColor: Colors.green,
                      submittedIcon: Icon(
                        Icons.done,
                        size: 20,
                        color: Colors.white,
                      ),
                      sliderButtonIcon: Icon(
                        Icons.double_arrow,
                        color: Colors.white60,
                      ),
                      child: Text(
                        "Slide to accept order",
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 10),
                    ),
                  ],
                ),
              ]),
            ]));
  }

  FoodItems(int index) {
    return Row(
      children: [
        Text(
          "1x McAloo Tikki + Fries(M)",
          style: subText,
        ),
        Spacer(),
        Text(
          rs + "450",
          style: subText,
        )
      ],
    );
  }
}
