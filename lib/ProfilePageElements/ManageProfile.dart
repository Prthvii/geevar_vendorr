import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';
import 'package:spicy_food_vendor/api/storeDetailApi.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  var arrStoreDetails;
  var storeName;
  var storeType;
  var address;
  var phoneNumber;
  var altphoneNumber;
  var city;
  var email;

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
      altphoneNumber = arrStoreDetails["altPhoneNumber"].toString();
      arrSliderImages = arrStoreDetails["logo"].toString();
      email = arrStoreDetails["email"].toString();
    }
    setState(() {
      isLoading = false;
    });

    print(
        "``````````````````````````````````catogerrrrry``````````````````````````````````");
    print(arrStoreDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Profile",
          style: HeadingTextStyle,
        ),
      ),
      body: (isLoading == true)
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonalDetails(),
                ],
              ),
            ),
    );
  }

  Widget SellerDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            arrSliderImages,
                          ),
                          fit: BoxFit.cover))),
              Text(
                storeName,
                style: boldTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                address,
                style: subTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                city,
                style: subTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   alignment: Alignment.center,
              //   width: 60,
              //   decoration: BoxDecoration(
              //       color: Colors.grey[200],
              //       borderRadius: BorderRadius.circular(15)),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           "4.9",
              //           style: TextStyle(
              //               fontWeight: FontWeight.w600, fontSize: 16),
              //         ),
              //         Icon(
              //           Icons.star,
              //           color: Colors.yellow[600],
              //           size: 16,
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget PersonalDetails() {
    return Flexible(
      child: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          SellerDetails(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Owner Details",
              style: subTextStyle,
            ),
          ),
          Tile("Name", storeName, () {}),
          Tile("Phone", "+91 " + phoneNumber.toString(), () {}),
          Tile("Email", email.toString(), () {}),
          DividerWidget,
          Padding(
            padding: const EdgeInsets.all(
              10,
            ),
            child: Text(
              "Manager Details",
              style: subTextStyle,
            ),
          ),
          Tile("Name", storeName, () {}),
          Tile("Phone", "+91 " + phoneNumber.toString(), () {}),
          Tile("Email", email.toString(), () {}),
          DividerWidget,
          Padding(
            padding: const EdgeInsets.all(
              10,
            ),
            child: Text(
              "Outlet Contact Numbers",
              style: subTextStyle,
            ),
          ),
          Tile("Phone", "+91 " + phoneNumber, () {}),
          Tile("Alternate Phone", "+91 9426585545", () {}),
          SizedBox(
            height: 20,
          )
        ]).toList(),
      ),
    );
  }

  Widget Tile(String label, String trail, GestureTapCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: ProfileSmallText,
      ),
      trailing: Text(
        trail,
        style: ProfileSmallTextGrey,
      ),
    );
  }
}
