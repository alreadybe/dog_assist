import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart';
import './utils/localstore.dart';

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
import './screens/fullYearCalendar.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Happy Dog',
        routes: {
          '/buylist': (context) => BuyList(),
          '/calendar': (context) => Calendar(),
          '/notes': (context) => Notes(),
          '/profile': (context) => Profile(),
          '/training': (context) => Training(),
          '/statistics': (context) => Statistics(),
          '/settings': (context) => Settings(),
          '/fullyear': (context) => FullYearCalendar(),
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

  FlutterLocalNotificationsPlugin notificationPlugin;

  String defaulLocal = Intl.getCurrentLocale();

  var soonEvents = [];

  getData() async {
    DateTime today = DateTime.now();
    var fetchData = await readData('events') ?? [];

    var events = fetchData
            .where((event) =>
                DateTime.parse(event["date"])
                    .isBefore(today.add(Duration(hours: 24))) &&
                DateTime.parse(event["date"])
                    .isAfter(today.subtract(Duration(hours: 23))))
            .toList() ??
        [];

    setState(() {
      soonEvents = events;
    });
  }

  Future onSelectNotifications(String payload) async {
    Navigator.pushNamed(context, '/');
  }

  Future showNotification(title, desc, date) async {
    await notificationPlugin.pendingNotificationRequests();

    var sheduledTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.orangeAccent,
              accentColor: Colors.orange,
              colorScheme: ColorScheme.light(primary: Colors.orange),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });

    DateTime sheduledTime = DateTime.parse(date)
        .subtract(Duration(hours: 1))
        .add(Duration(
            hours: sheduledTimeOfDay.hour, minutes: sheduledTimeOfDay.minute));

    print(sheduledTime);

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channel_id', 'channed_name', 'channel_description',
        importance: Importance.High, priority: Priority.High);

    var iosPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);

    await notificationPlugin.schedule(DateTime.now().millisecond, title, desc,
        sheduledTime, platformChannelSpecifics);
  }

  @override
  void initState() {
    loading = true;

    getLocale();
    getData();

    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    notificationPlugin = new FlutterLocalNotificationsPlugin();
    notificationPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotifications);
  }

  _getLangFromSettings(BuildContext context) async {
    final lang = await Navigator.pushNamed(context, '/settings');
    if (lang) getData();
  }

  goToPage(context, path) async {
    final refreshed = await Navigator.pushNamed(context, path);
    if (refreshed) getData();
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
                  child: HeaderBar(S.of(context).title, false, 'setting', () {
                    _getLangFromSettings(context);
                  }),
                  preferredSize: Size(double.infinity, kToolbarHeight)),
              body: AppBody(soonEvents, showNotification),
              bottomNavigationBar: BottomBar(goToPage),
            ),
    );
  }
}
