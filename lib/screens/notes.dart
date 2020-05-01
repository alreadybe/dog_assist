import 'package:flutter/material.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Notes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotesState();
  }
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.black38,
            appBar: PreferredSize(
                child: HeaderBar(S.of(context).notes, true, false),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: Text('Notes'),
            )));
  }
}
// This widget is the root of your application.
