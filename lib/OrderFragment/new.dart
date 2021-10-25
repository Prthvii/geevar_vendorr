import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/api/acceptOrderApi.dart';
import 'package:spicy_food_vendor/api/orderListingApi.dart';
import 'package:spicy_food_vendor/api/rejectOrderApi.dart';
import 'package:spicy_food_vendor/helper/timeHelper.dart';

class NewOrder extends StatefulWidget {
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<NewOrder> {
  String BoardDropdownValue;

  var time = "0";
  double _progress = 0;
  double _lowerValue = 5;
  double _upperValue = 45;
  var isLoading = true;
  List<dynamic> arrProdList = [];
  List<dynamic> arrList = [];
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  void initState() {
    this.getProducts();
  }

  Future<String> getProducts() async {
    setState(() {
      isLoading = true;
    });
    var rsp = await orderListingApi();
    if (rsp != null) {
      arrList.clear();
      arrProdList.clear();
      setState(() {
        arrList = rsp['orders'];
      });

      for (var i = 0; i < arrList.length; i++) {
        if (arrList[i]['orderStatus'] == 1) {
          arrProdList.add(arrList[i]);
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    print("catogerrrrry");
    print(arrProdList);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getProducts(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : arrProdList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image(
                        image: AssetImage("assets/images/nodata.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: (isLoading == true)
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 200),
                            child: Column(
                              children: [
                                OrderDetailsListView(),
                                Divider(),
                              ],
                            )),
                  ),
      ),
    );
  }

  OrderDetailsListView() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => DividerWidget,
      shrinkWrap: true,
      itemCount: arrProdList != null ? arrProdList.length : 0,
      itemBuilder: (context, index) {
        final item = arrProdList != null ? arrProdList[index] : null;
        return OrderDetails(item, index);
      },
    );
  }

  OrderDetails(item, index) {
    return Container(
      child: Column(
        children: [
          OrderIdDetails(item, index),
          OrderItem(item, index),
          Divider(),
          TotalBill(item, index),
          OrderReadyWidget(item, index)
        ],
      ),
    );
  }

  OrderIdDetails(var item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "ID: " + item['orderNo'].toString(),
                style: subText,
              ),
              Spacer(),
              Text(
                parseTimeFromUtc(item['createdAt'].toString()).toString(),
                style: subTextStyle,
              ),

            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    getStatus(item['orderStatus']).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    parseDateFromUtc(item['createdAt'].toString()).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 5,
              // ),
              // Text(
              //   "Aron's 5th order",
              //   style: greenText,
              // )
            ],
          ),
        ],
      ),
    );
  }

  OrderItem(var item, var index) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: item['products'] != null ? item['products'].length : 0,
      itemBuilder: (context, index) {
        final items = item['products'] != null ? item['products'][index] : null;
        return OrderItemDetails(items, index);
      },
    );
  }

  OrderItemDetails(var item, var index) {
    // print("itemsssssssssssssss");
    // print(item);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            item['quantity'].toString() + "x ",
            style: subText,
          ),
          Text(
            item['details']['name'].toString(),
            style: subText,
          ),
          Spacer(),
          Text(
            rs + item['sellPrice'].toString(),
            style: subText,
          )
        ],
      ),
    );
  }

  TotalBill(var item, var index) {
    return ExpansionTile(
      title: Row(
        children: [
          Text(
            "Total bill : " + rs + item['storeEarning'].toString(),
            style: TextStyle(fontSize: 14, color: Color(0xff848891)),
          ),
          SizedBox(
            width: 10,
          ),
          // Container(
          //   child: Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: Text(
          //       "PAID",
          //       style: TextStyle(color: Colors.grey[500], fontSize: 10),
          //     ),
          //   ),
          //   color: Colors.grey[200],
          // )
        ],
      ),
      children: [Text("aaaa")],
    );
  }

  OrderReadyWidget(var item, var index) {
    return GestureDetector(
      onTap: () async {
        _onBackPressed(item['orderNo'].toString(), index);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "Accept",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(var id, int index) {
    return showDialog(
          context: context,
          builder: (BuildContext  context) => new AlertDialog(
            title: new Text('Accepting ?'),

        content: StatefulBuilder(  // You need this, notice the parameters below:
            builder: (BuildContext context, StateSetter setState)
            {
              return  SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Pick cooking time: "),
                    Container(
                      child: DropdownButton<String>(
                        value: BoardDropdownValue,
                        isExpanded: false,
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 25,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        hint: Text(
                          time,
                        ),
                        underline: Container(),
                        style: const TextStyle(
                          color: Color(
                            0xff446270,
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            BoardDropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          '5',
                          '10',
                          '20',
                          '30',
                          '45',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            onTap: (){
                              setState(() {
                                time=value;
                              });
                            },
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );

            }),

            actionsPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(width: 16),
              new GestureDetector(
                onTap: () async {
                  var rsp = await acceptOrderApi(id, time);
                  if (rsp != 0) {
                    print("lengthh");
                    print(arrProdList.length);
                    setState(() {
                      arrProdList.removeAt(index);
                    });

                    print(arrProdList.length);

                    Navigator.pop(context);
                    //  getProducts();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text("YES"),
              ),
            ],
          ));

  }

  Future<bool> _rejectPressed(var id, int index) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Accepting ?'),
            content: new Text('Did you want to reject this order !'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () async {
                  var rsp = await rejectOrderApi(id);
                  if (rsp != 0) {
                    print("lengthh");
                    print(arrProdList.length);
                    setState(() {
                      arrProdList.removeAt(index);
                    });

                    print(arrProdList.length);

                    Navigator.pop(context);
                    //  getProducts();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget Slider() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: FlutterSlider(
          selectByTap: true,
          trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(color: Colors.red),
              inactiveTrackBar: BoxDecoration(color: Colors.red[100])),
          handler: FlutterSliderHandler(
            decoration: BoxDecoration(),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                  border: Border.all(color: Colors.grey[100]),
                  shape: BoxShape.circle,
                  color: Colors.white),
              padding: EdgeInsets.all(5),
            ),
          ),
          values: [5, 45],
          max: 45,
          hatchMark: FlutterSliderHatchMark(
              density: 0.5,
              labels: [
                FlutterSliderHatchMarkLabel(
                    percent: 0,
                    label: Text(
                      '5',
                      style: TextStyle(fontSize: 15),
                    )),
                FlutterSliderHatchMarkLabel(percent: 20, label: Text('10')),
                FlutterSliderHatchMarkLabel(percent: 50, label: Text('20')),
                FlutterSliderHatchMarkLabel(percent: 80, label: Text('30')),
                FlutterSliderHatchMarkLabel(percent: 100, label: Text('45')),
              ],
              labelsDistanceFromTrackBar: 45),
          fixedValues: [
            FlutterSliderFixedValue(
              percent: 0,
              value: "5 min",
            ),
            FlutterSliderFixedValue(percent: 20, value: "10 min"),
            FlutterSliderFixedValue(percent: 50, value: "20 min"),
            FlutterSliderFixedValue(percent: 80, value: "30 min"),
            FlutterSliderFixedValue(percent: 100, value: "45 min")
          ],
          min: 0,
          onDragging: (handlerIndex, lowerValue, upperValue) {
            _lowerValue = lowerValue;
            _upperValue = upperValue;
            setState(() {});
          },
          tooltip: FlutterSliderTooltip(
            format: (String value) {
              setState(() {
                time = value.toString();
              });
              return value;
            },
            textStyle: TextStyle(fontSize: 17, color: Colors.red),
          )),
    );
  }
}
