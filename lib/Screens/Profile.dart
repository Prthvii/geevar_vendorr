import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/ProfilePageElements/ManageProfile.dart';
import 'package:spicy_food_vendor/ProfilePageElements/OrderHistory.dart';
import 'package:spicy_food_vendor/SubPages/EnterNum.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/api/storeDetailApi.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var arrStoreDetails;
  var storeName;
  var storeType;
  var address;
  var phoneNumber;
  var city;

  var arrSliderImages;

  var arrProdList;
  var isLoading = true;

  @override
  void initState() {
    this.getDetails();
    super.initState();
  }

  Future<String> getDetails() async {
    var rsp = await storeDetailApi();
    print("rsppppppppppp");
    if (rsp != null) {
      arrStoreDetails = rsp;
      storeName = arrStoreDetails["name"].toString();
      storeType = arrStoreDetails["storeType"].toString();
      address = arrStoreDetails["address"].toString();
      city = arrStoreDetails['city']["name"].toString();
      phoneNumber = arrStoreDetails["phoneNumber"].toString();
      phoneNumber = arrStoreDetails["phoneNumber"].toString();
      arrSliderImages = arrStoreDetails["logo"].toString();
      // print(storeName);
    }
    setState(() {
      isLoading = false;
    });

    print("catogerrrrry");
    print(arrStoreDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isLoading == true)
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameSection(),
                      Divider(),
                      NewTiles(),
                    ],
                  ),
                ),
              ));
  }

  NameSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            arrSliderImages.toString(),
                          ),
                          fit: BoxFit.cover))),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeName,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    address,
                    style: TextStyle(fontSize: 14, color: Color(0xff848891)),
                  )
                ],
              ),
            ),
            Spacer(),
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(15)),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Text(
            //           "4.9",
            //           style:
            //               TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            //         ),
            //         Icon(
            //           Icons.star,
            //           color: Colors.yellow[600],
            //           size: 18,
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  ContactDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.phone_android_sharp,
                color: Colors.blue,
                size: 18,
              ),
              Text(
                "+91 " + phoneNumber,
                style: subTextStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 18,
              ),
              Text(
                city.toString(),
                style: subTextStyle,
              )
            ],
          ),
        )
      ],
    );
  }

  NewTiles() {
    return Flexible(
      child: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ContactDetails(),
          Tile("Manage Profile", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageProfile()),
            );
          }),
          // Tile("Payments & Accounts", () {}),
          // Tile("Schedule off-time in advance", () {}),
          // Tile("Update timings", () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => UpdateTime()),
          //   );
          // }),
          Tile("Order history", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistory()),
            );
          }),
          Tile("Support", () {}),
          Tile("Share your feedback", () {}),
          SizedBox(
            height: 20,
          ),
          LogoutButton(),
          SizedBox(
            height: 20,
          ),
        ]).toList(),
      ),
    );
  }

  Widget Tile(String label, GestureTapCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: profileText,
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  LogoutButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EnterNumber()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Logout",
              style: blueTextStyle,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: themeColor)),
        ),
      ),
    );
  }
}
