import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  bool initLocal = false;
  String currentLocale = '';

  setInitialLocal(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('local', value);
  }

  getInitialLocal(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String defaulLocal = Localizations.localeOf(context).toString();

    String savedLocal = prefs.getString('local') ?? defaulLocal;

    setState(() {
      if (savedLocal == 'ru') currentLocale = "Русский";
      if (savedLocal == 'en') currentLocale = "English";
    });
  }

  getValueLocal(value) {
    if (value == 'ru') return "Русский";
    if (value == 'en') return "English";
  }

  @override
  void initState() {
    initLocal = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (initLocal) {
      setState(() {
        getInitialLocal(context);
        initLocal = false;
      });
    }

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.black38,
            appBar: PreferredSize(
                child: HeaderBar(S.of(context).settings, true, false, null),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 15, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          S.of(context).changeLang,
                          style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(currentLocale,
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600))),
                              PopupMenuButton(
                                onSelected: (value) async {
                                  await S.load(Locale(value));
                                  setInitialLocal(value);
                                  setState(() {
                                    currentLocale = getValueLocal(value);
                                  });
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                      value: 'ru',
                                      child: Text("Русский",
                                          style: GoogleFonts.rubik(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w400)))),
                                  PopupMenuItem(
                                      value: 'en',
                                      child: Text("English",
                                          style: GoogleFonts.rubik(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w400)))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
