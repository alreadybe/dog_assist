import 'package:flutter/material.dart';

import '../components/Calendar/CalendarBody.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.black38,
            appBar: PreferredSize(
                child: HeaderBar(S.of(context).calendar, true, false, null),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              margin: EdgeInsets.only(top: 140),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CalendarBody(31)],
                  ),
                ],
              ),
            )));
  }
}
// This widget is the root of your application.
