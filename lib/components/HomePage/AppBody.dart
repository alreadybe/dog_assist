import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CalendarFeedWidget(),
        ],
      ),
    );
  }
}

class CalendarFeedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black54,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        padding: EdgeInsets.all(10),
        height: 90,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.restaurant_menu,
              size: 32,
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Feed dog at 14:30',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w200))),
            ),
            Container(
              padding: EdgeInsets.only(left: 70),
              child: Icon(
                Icons.notifications,
                size: 34,
                color: Colors.orange,
              ),
            ),
          ],
        ));
  }
}
