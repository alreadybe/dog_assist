import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.restaurant_menu,
              size: 32,
              color: Colors.green,
            ),
            Text(S.of(context).test,
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200))),
            Container(
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
