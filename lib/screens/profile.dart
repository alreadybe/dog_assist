import 'package:flutter/material.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.black38,
            appBar: PreferredSize(
                child: HeaderBar(S.of(context).profile, true, false),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: Text('Profile'),
            )));
  }
}
// This widget is the root of your application.
