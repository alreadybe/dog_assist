import 'package:flutter/material.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Training extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrainingState();
  }
}

class _TrainingState extends State<Training> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.black38,
            appBar: PreferredSize(
                child: HeaderBar(S.of(context).training, true, null, null),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: Text('Training'),
            )));
  }
}
// This widget is the root of your application.
