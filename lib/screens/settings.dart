import 'package:flutter/material.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.black38,
            appBar: PreferredSize(
                child: HeaderBar(S.of(context).settings, true, false),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: Text('Setting'),
            )));
  }
}
