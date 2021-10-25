import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class UpdateTime extends StatefulWidget {
  @override
  _UpdateTimeState createState() => _UpdateTimeState();
}

class _UpdateTimeState extends State<UpdateTime> {
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
            "Update timings",
            style: HeadingTextStyle,
          ),
        ),
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            Tile("Monday", "Closed"),
            Tile("Tuesday", "Closed"),
            Tile("Wednesday", "Closed"),
            Tile("Thursday", "Closed"),
            Tile("Friday", "Closed"),
            Tile("Saturday", "Closed"),
            Tile("Sunday", "Closed"),
          ]).toList(),
        ));
  }

  Widget Tile(String Day, String Status) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(5),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "+ Add / Edit Time",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
        )
      ],
      title: ListTile(
        // onTap: onTap,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Day,
              style: profileText,
            ),
            Text(" • "),
            Text(
              Status,
              style: RedText,
            )
          ],
        ),
        // trailing: Icon(Icons.keyboard_arrow_right),
      ),
      // trailing: Icon(Icons.keyboard_arrow_down),
    );
  }
}
