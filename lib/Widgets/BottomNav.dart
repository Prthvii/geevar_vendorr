import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spicy_food_vendor/Screens/Menu.dart';
import 'package:spicy_food_vendor/Screens/Orders.dart';
import 'package:spicy_food_vendor/Screens/Payout.dart';
import 'package:spicy_food_vendor/Screens/Profile.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> viewContainer = [
    Orders(),
    Menu(),
    Payout(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: viewContainer[_currentIndex],
        bottomNavigationBar: CustomNavigationBar(
          scaleFactor: 0.5,
          unSelectedColor: Colors.grey,
          strokeColor: Colors.deepOrangeAccent,
          elevation: 0,
          iconSize: 25,
          blurEffect: true,
          backgroundColor: Colors.white12,
          key: _bottomNavigationKey,
          currentIndex: _currentIndex,
          onTap: (index) {
            print(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedTitle: Text(
                "Orders",
                style: blueText,
              ),
              selectedIcon: Icon(Icons.shopping_bag),
              title: Text(
                "Orders",
                style: greyColor,
              ),
            ),
            CustomNavigationBarItem(
              selectedTitle: Text(
                "Menu",
                style: blueText,
              ),
              title: Text(
                "Menu",
                style: greyColor,
              ),
              icon: Icon(
                Icons.article_outlined,
                size: 20,
              ),
              selectedIcon: Icon(Icons.article_rounded),
            ),
            CustomNavigationBarItem(
              selectedTitle: Text(
                "Payout",
                style: blueText,
              ),
              title: Text(
                "Payout",
                style: greyColor,
              ),
              icon: Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
              ),
              selectedIcon: Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
              ),
            ),
            CustomNavigationBarItem(
              selectedTitle: Text(
                "Profile",
                style: blueText,
              ),
              title: Text(
                "Profile",
                style: greyColor,
              ),
              icon: Icon(
                Icons.person_outline,
              ),
              selectedIcon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if (_currentIndex != 0) {
      print("aaaaaaaaaaaaaa");
      setState(() {
        _currentIndex = 0;
        print(_currentIndex);
      });
    } else {
      print("dgvsgdbvadsbhb");
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 10,
        title: Text('Confirm Exit!'),
        titleTextStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.6,
            color: Color(0xff333333),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}

final greyColor = TextStyle(color: Colors.grey);
