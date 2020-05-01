import 'package:flutter/material.dart';

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
                child: HeaderBar(S.of(context).calendar, true, false),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: Text('Calendar'),
            )));
  }
}
// This widget is the root of your application.
