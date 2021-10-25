import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
          "Notifications",
          style: HeadingTextStyle,
        ),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[400],
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Noti(index);
          },
          itemCount: 2,
        ),
      ),
    );
  }

  Noti(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue[100]),
                child: Icon(
                  Icons.notifications,
                  color: Colors.blue[500],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile Feedback",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Dear delivery partner heasjfnasjcnasocnnssssssssssssssskkkkkkkkkkkkkkkkkkkk",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ProfileSmallText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "2 hours ago",
                    style: TextStyle(
                        color: themeColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
