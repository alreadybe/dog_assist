import 'dart:convert';

import 'package:DogAssistant/components/Calendar/AddEvent.dart';
import 'package:DogAssistant/components/Calendar/Filter..dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:date_util/date_util.dart';
import 'package:intl/intl.dart';

import '../utils/localstore.dart';

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
  String currentDateString;

  String name;
  String filter;
  String filterName;

  var events;
  List currentEvents = [];

  var addActive;

  var showModal;

  var eventName;
  var eventNote;

  var daysInMonth;
  var days;
  var step;

  getData() async {
    var fetchData = await readData('events') ?? [];
    var formatMonth =
        currentMonth.toString().length > 1 ? currentMonth : '0$currentMonth';
    var formatDay =
        selectedDay.toString().length > 1 ? selectedDay : '0$selectedDay';

    var todayEvents = fetchData
        .where((event) =>
            event['date'] == '$currentYear-$formatMonth-$formatDay 01:00:00')
        .toList();

    setState(() {
      events = fetchData;
      currentEvents = todayEvents;
    });
  }

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
    selectDay(selectedDay.toString());
  }

  prevMonth() {
    var newDate = DateTime(currentYear, currentMonth - 1, 1);
    setState(() {
      currentMonth = newDate.month;
      currentYear = newDate.year;
    });
    getMonthData(newDate);
    selectDay(selectedDay.toString());
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
    if (eventName != null && eventName.length > 0 || filter != 'other') {
      String category = filter == 'other' ? eventName : filter;
      var formatMonth =
          currentMonth.toString().length > 1 ? currentMonth : '0$currentMonth';
      var formatDay =
          selectedDay.toString().length > 1 ? selectedDay : '0$selectedDay';

      var event = {
        "category": category,
        "note": eventNote,
        "date": '$currentYear-$formatMonth-$formatDay 01:00:00'
      };

      writeData(event, 'events');

      setState(() {
        showModal = false;
        filter = '';

        eventName = '';
        eventNote = '';

        events.add(event);
        currentEvents.add(event);
      });
    }
  }

  selectDay(day) {
    var month =
        currentMonth.toString().length > 1 ? currentMonth : '0$currentMonth';
    var parsedDay = day.toString().length > 1 ? day : '0$day';
    DateTime currentFullDay =
        DateTime.parse('$currentYear-$month-$parsedDay 02:00:00');
    setState(() {
      selectedDay = int.parse(day);
      currentDateString = DateFormat.MMMEd().format(currentFullDay);
    });

    getData();
  }

  openFullCalendar() async {
    var routes = await Navigator.pushNamed(context, '/fullyear');
    Map selectedMonth = jsonDecode(jsonEncode(routes));
    int sMonth = selectedMonth['month'];
    int sYear = selectedMonth['year'];

    var newDate = DateTime(sYear, sMonth, 1);
    setState(() {
      currentMonth = newDate.month;
      currentYear = newDate.year;
    });
    getMonthData(newDate);
    selectDay(selectedDay.toString());
  }

  @override
  void initState() {
    getData();

    currentMonth = today.month;
    currentYear = today.year;

    currentDateString = DateFormat.MMMEd().format(today);

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
              child: HeaderBar(
                  S.of(context).calendar, true, 'calendar', openFullCalendar),
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
                        margin: EdgeInsets.only(top: 85),
                        child: Stack(children: <Widget>[
                          Container(
                            width: 380,
                            height: 382,
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
                                      '$currentDateString',
                                      style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: 195,
                                      height: 150,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: currentEvents.length > 0
                                          ? ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: currentEvents.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      _noteItem(
                                                          currentEvents[index]
                                                              ['category'],
                                                          currentEvents[index]
                                                              ['note'],
                                                          context))
                                          : Text(
                                              S.of(context).emptyNotes,
                                              style: GoogleFonts.rubik(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              textAlign: TextAlign.center,
                                            )),
                                  currentEvents.length > 0
                                      ? Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text(
                                            currentEvents.length.toString(),
                                            style: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          for (var item in daysInMonth)
                            DayItem(item, step, selectedDay, selectDay)
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

Container _noteItem(category, note, context) {
  var name;
  switch (category) {
    case 'vet':
      name = S.of(context).vet;
      break;
    case 'dhandler':
      name = S.of(context).dhandler;
      break;
    case 'fight':
      name = S.of(context).fight;
      break;
    case 'measuring':
      name = S.of(context).measuring;
      break;
    case 'mating':
      name = S.of(context).mating;
      break;
    default:
      name = category;
      break;
  }

  return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          note.length > 0
              ? (Text(
                  name,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  textAlign: TextAlign.left,
                ))
              : SizedBox(
                  height: 5,
                ),
          Text(
            note.length > 0 ? note : name,
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            textAlign: TextAlign.center,
          ),
        ],
      ));
}
