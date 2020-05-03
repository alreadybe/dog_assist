import 'package:DogAssistant/components/Calendar/AddEvent.dart';
import 'package:DogAssistant/components/Calendar/Filter..dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:date_util/date_util.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

import '../components/Calendar/DayItem.dart';
import '../components/Calendar/AddEvent.dart';

class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarState();
  }
}

class CalendarState extends State<Calendar> {
  var dateUtility = DateUtil();

  DateTime today = DateTime.now();

  int currentMonth;
  int currentYear;

  int selectedDay;

  String name;
  String filter;
  String filterName;

  var addActive;

  var showModal;

  var eventName;
  var eventNote;

  var daysInMonth;
  var days;
  var step;

  getMonthData(date) {
    String monthName = DateFormat.MMMM().format(date);
    String parsedName =
        monthName.replaceRange(0, 1, monthName.substring(0, 1).toUpperCase());

    int day = dateUtility.daysInMonth(date.month, date.year);

    var result = [];
    var todayDay = today.day;
    for (var i = 0; i < day; i++) {
      result.add({
        "day": i + 1,
        "active": i + 1 == todayDay && today.month == currentMonth,
      });
    }

    setState(() {
      name = parsedName;
      days = day;
      step = days / 158;
      selectedDay = today.day;
      daysInMonth = result;
    });
  }

  nextMonth() {
    var newDate = DateTime(currentYear, currentMonth + 1, 1);
    setState(() {
      currentMonth = newDate.month;
      currentYear = newDate.year;
    });
    getMonthData(newDate);
  }

  prevMonth() {
    var newDate = DateTime(currentYear, currentMonth - 1, 1);
    setState(() {
      currentMonth = newDate.month;
      currentYear = newDate.year;
    });
    getMonthData(newDate);
  }

  setFilter(name, text) {
    setState(() {
      addActive = false;
      showModal = true;
      filter = name;
      filterName = text;
    });
  }

  setActive() {
    setState(() {
      addActive = !addActive;
    });
  }

  addEvent() {
    print(eventName);
    print(eventNote);
    print(selectedDay);
    print(currentMonth);
    print(currentYear);

    if (eventName.length > 0) {
      setState(() {
        showModal = false;
        filter = '';
      });
    }
  }

  @override
  void initState() {
    currentMonth = today.month;
    currentYear = today.year;

    addActive = false;
    showModal = false;

    getMonthData(today);

    super.initState();
  }

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
          body: Stack(children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      prevMonth();
                                    }),
                                Text('$name',
                                    style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600))),
                                IconButton(
                                    icon: Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      nextMonth();
                                    }),
                              ],
                            ),
                            Text('$currentYear',
                                style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 90),
                        child: Stack(children: <Widget>[
                          Container(
                            width: 380,
                            height: 380,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              border: Border.all(
                                  width: 24, color: Color(0xFF494949)),
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              width: 260,
                              height: 260,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      'Sunday, 29 April',
                                      style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Notes about this date sfasfasfka jfaphs fjasph ufahps ufahsp ufahpf uhspuiaf fief fiefj ifejfeifjqe ijfe',
                                      style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          for (var item in daysInMonth)
                            DayItem(item, step, selectedDay, this)
                        ]),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: showModal ? AddEvent(filter, this) : SizedBox()),
          ]),
          bottomNavigationBar: Container(
              color: showModal ? Color(0xFF171717) : Colors.transparent,
              height: 172,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  addActive
                      ? FilterBar(filter, setFilter)
                      : SizedBox(
                          height: 85,
                        ),
                  IconButton(
                    color: Colors.green,
                    iconSize: 52,
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      if (showModal)
                        addEvent();
                      else
                        setActive();
                    },
                  ),
                ],
              )),
        ));
  }
}
