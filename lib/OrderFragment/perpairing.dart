import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/api/orderListingApi.dart';
import 'package:spicy_food_vendor/api/readyToPickupApi.dart';
import 'package:spicy_food_vendor/helper/timeHelper.dart';

class PrepairingOrder extends StatefulWidget {
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<PrepairingOrder> {
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
        if (arrList[i]['orderStatus'] == 2) {
          arrProdList.add(arrList[i]);
        }
        if (arrList[i]['orderStatus'] == 3) {
          arrProdList.add(arrList[i]);
        }
      }

      setState(() {
        isLoading = false;
      });
    }
    //
    // print("catogerrrrry");
    // print(arrProdList);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getProducts(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),

        child: (isLoading == true)
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              )
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
                : Container(
            margin: EdgeInsets.only(bottom: 200),

            child: Column(
                    children: [
                      OrderDetailsListView(),
                      Divider(),
                    ],
                  )),
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
          //TotalBill(item, index),
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
            style: subTextStyle,
          ),
          SizedBox(
            width: 5,
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
            color: themeColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "Ready",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );

    SlideAction(
      height: 50,
      key: _key,
      onSubmit: () {
        Future.delayed(
          Duration(seconds: 1),
          () => _key.currentState.reset(),
        );
        Navigator.pop(context);
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
            color: Colors.white60, fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }

  Future<bool> _onBackPressed(var id, int index) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm ?'),
            content: new Text('Did you want to change the status !'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () async {
                  var rsp = await readyToPickupApi(id);
                  if (rsp != 0) {
                    // print("lengthh");
                    // print(arrProdList.length);
                    setState(() {
                      arrProdList.removeAt(index);
                    });

                    // print(arrProdList.length);

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
}
