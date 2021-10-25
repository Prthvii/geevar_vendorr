import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/api/getProductsAPI.dart';
import 'package:spicy_food_vendor/api/prodStockUpdateApi.dart';
import 'package:spicy_food_vendor/api/storeDetailApi.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var arrStoreDetails;
  var storeName;
  var storeType;
  var address;

  var arrSliderImages;

  var arrProdList;
  var isLoading = true;

  @override
  void initState() {
    this.getDetails();
    this.getProducts();
  }

  Future<String> getDetails() async {
    var rsp = await storeDetailApi();
    print("rsppppppppppp");
    if (rsp != null) {
      arrStoreDetails = rsp;
      storeName = arrStoreDetails["name"].toString();
      storeType = arrStoreDetails["storeType"].toString();
      address = arrStoreDetails["address"].toString();
      arrSliderImages = arrStoreDetails["logo"].toString();
      // print(storeName);
    }
    setState(() {
      isLoading = false;
    });

    print("catogerrrrry");
    print(arrStoreDetails);
  }

  Future<String> getProducts() async {
    var rsp = await getProductsApi();
    if (rsp != null) {
      setState(() {
        arrProdList = rsp['categories'];
      });

      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: AppBar(
            brightness: Brightness.dark,
          )),
      backgroundColor: Colors.white,
      body: (isLoading == true)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    CoverImage(),
                    DetailsSection(),
                    Divider(),
                    FoodItem(),
                  ],
                ),
              ),
            ),
    );
  }

  CoverImage() {
    return Image(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        fit: BoxFit.cover,
        image: arrSliderImages != null
            ? NetworkImage(arrSliderImages)
            : AssetImage("assets/images/food.jpg"));
  }

  DetailsSection() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeName != null ? storeName : "Loading....",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            Text(
              storeType != null ? storeType : "Loading....",
              style: subTextStyle,
            ),
            Row(
              // crossAxisAlignment: WrapCrossAlignment.start,
              // alignment: WrapAlignment.start,
              // spacing: 10,
              children: [
                Text(
                  address != null ? address : "Loading....",
                  style: subTextStyle,
                ),
                // SizedBox(
                //   width: 5,
                // ),
                // Container(
                //   height: 10,
                //   width: 2,
                //   color: Colors.grey[500],
                // ),
                // SizedBox(
                //   width: 5,
                // ),
                // Text(
                //   "3.1 KM",
                //   style: subTextStyle,
                // )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     Container(
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: themeColor,
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(15),
            //         child: Text(
            //           "All items 21",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Container(
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.white,
            //           border: Border.all(color: Colors.grey[400])),
            //       child: Padding(
            //         padding: const EdgeInsets.all(15),
            //         child: Text(
            //           "Out of stock 3",
            //           style: TextStyle(color: Colors.grey[400]),
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  // FoodDetailSection() {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 10),
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               Text(
  //                 "Starters",
  //                 style: boldTextStyle,
  //               ),
  //               Spacer(),
  //               IconButton(
  //                   icon: Icon(
  //                     Icons.more_vert,
  //                     color: Colors.grey[400],
  //                   ),
  //                   onPressed: () {})
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text(
  //                 "Non Veg Burgers",
  //                 style: subTextStyle,
  //               ),
  //               Spacer(),
  //               CupertinoSwitch(
  //                 value: isSwitched,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     isSwitched = value;
  //                     print(isSwitched);
  //                   });
  //                 },
  //                 activeColor: themeColor,
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  FoodItem() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => Divider(),
      shrinkWrap: true,
      //itemCount: 5,
      itemCount: arrProdList != null ? arrProdList.length : 0,
      itemBuilder: (context, index) {
        final item = arrProdList != null ? arrProdList[index] : null;
        return ExpansionTile(
          children: [
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(),
              shrinkWrap: true,
              itemCount: item['products'] != null ? item['products'].length : 0,
              itemBuilder: (context, index) {
                final items =
                    item['products'] != null ? item['products'][index] : null;
                return FoodDetails(items, index);
              },
            ),
          ],
          title: Text(item['name'].toString()),
        );
      },
    );
  }

  FoodDetails(var item, int index) {
    return Stack(children: [
      Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(item['image'].toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'].toString(),
                      style: subText,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    width: 1,
                                    color: item['isVeg'] == true
                                        ? Colors.green
                                        : Colors.red)),
                            alignment: Alignment.center,
                            child: Icon(Icons.brightness_1,
                                size: 9,
                                color: item['isVeg'] == true
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        Text(
                          rs + item['price'].toString(),
                          style: subText,
                        ),
                        // Icon(
                        //   Icons.star,
                        //   color: Colors.yellow[600],
                        //   size: 15,
                        // ),
                        // Text(
                        //   "Best Seller",
                        //   style: TextStyle(
                        //       color: Colors.yellow[600],
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 18),
                        // )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: Row(
            children: [
              // Spacer(),
              Text(
                item['isAvailable'] == true ? "In Stock" : "Stock Out",
                style: subTextStyle,
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: item['isAvailable'],
                  onChanged: (value) async {
                    if (item['isAvailable'] == true) {
                      setState(() {
                        item['isAvailable'] = false;
                        value = false;
                        print(item['isAvailable']);
                      });
                    } else {
                      setState(() {
                        item['isAvailable'] = true;
                        print(item['isAvailable']);
                        value = true;
                      });
                    }
                    var rsp = await prodStockUpdateApi(
                        item['id'].toString(), value.toString());
                    print("rspppp");
                    print(rsp);
                  },
                  activeColor: themeColor,
                ),
              ),
            ],
          ))
    ]);
  }
}
