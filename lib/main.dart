import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart';

import 'components/HeaderBar.dart';

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
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool loading;
  String refresh;
  String currentLocale;

  String defaulLocal = Intl.getCurrentLocale();

  @override
  void initState() {
    loading = true;
    getLocale();

    super.initState();
  }

  _getLangFromSettings(BuildContext context) async {
    final lang = await Navigator.pushNamed(context, '/settings');

    setState(() {
      refresh = lang;
    });
  }

  getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String local = prefs.getString('local') ?? null;

    if (local != null && local != currentLocale) {
      setState(() {
        loading = true;
      });
      await S.load(Locale(local));

      setState(() {
        currentLocale = local;
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      child: loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
              ),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  child: HeaderBar(S.of(context).title, false, true, () {
                    _getLangFromSettings(context);
                  }),
                  preferredSize: Size(double.infinity, kToolbarHeight)),
              body: AppBody(),
              bottomNavigationBar: BottomBar(),
            ),
    );
  }
}
