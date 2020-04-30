import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './components/HomePage/AppBody.dart';
import './components/HomePage/BottomBar.dart';

import './screens/buylist.dart';
import './screens/calendar.dart';
import './screens/notes.dart';
import './screens/profile.dart';
import './screens/training.dart';
import './screens/statistics.dart';
import './screens/settings.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lucky Dog',
        routes: {
          '/buylist': (context) => BuyList(),
          '/calendar': (context) => Calendar(),
          '/notes': (context) => Notes(),
          '/profile': (context) => Profile(),
          '/training': (context) => Training(),
          '/statistics': (context) => Statistics(),
          '/settings': (context) => Settings(),
        },
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
                child: HeaderBar('Lucky Dog', false),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: AppBody(),
            bottomNavigationBar: BottomBar(),
          ),
        ));
  }
}
