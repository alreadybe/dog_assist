import 'package:DogAssistant/components/Calendar/Filter..dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';
import '../utils/localstore.dart';

import 'package:date_util/date_util.dart';
import 'package:intl/intl.dart';

import '../components/HeaderBar.dart';

class FullYearCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullYearCalendarState();
  }
}

class FullYearCalendarState extends State<FullYearCalendar> {
  int year;
  String filter;

  var allEvents;
  var currentEvents;
  var filterEvents;

  nextYear() {
    setState(() {
      year = year + 1;
    });
    getFilteredEvent();
  }

  prevYear() {
    setState(() {
      year = year - 1;
    });
    getFilteredEvent();
  }

  getFilteredEvent() async {
    var yearsEvents = await allEvents
        .where((event) => DateTime.parse(event['date']).year == year)
        .toList();

    var filterEvent = await yearsEvents
        .where((event) => event["category"] == filter)
        .toList();

    setState(() {
      currentEvents = yearsEvents;
      filterEvents = filterEvent;
    });
  }

  setFilter(name, text) {
    setState(() {
      filter = name;
    });
    getFilteredEvent();
  }

  getData() async {
    var fetchData = await readData('events') ?? [];

    setState(() {
      allEvents = fetchData;
    });
    await getFilteredEvent();
  }

  @override
  void initState() {
    filter = '';
    year = DateTime.now().year;

    getData();
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
                child: HeaderBar(S.of(context).calendar, true, null, null),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () {
                                  prevYear();
                                }),
                            Text('$year',
                                style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600))),
                            IconButton(
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () {
                                  nextYear();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: CalendarYear(year, filterEvents)),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      child: FilterBar(filter, setFilter)),
                ],
              ),
            )));
  }
}

class CalendarYear extends StatelessWidget {
  final year;
  final events;

  CalendarYear(this.year, this.events);

  getMonthEvents(month) {
    if (events != null) {
      var monthEvent = events
          .where((event) => DateTime.parse(event['date']).month == month)
          .toList()
          .map((event) => DateTime.parse(event['date']).day);

      return monthEvent;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CalendarMonth(1, year, getMonthEvents(1)),
              CalendarMonth(2, year, getMonthEvents(2)),
              CalendarMonth(3, year, getMonthEvents(3)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CalendarMonth(4, year, getMonthEvents(4)),
              CalendarMonth(5, year, getMonthEvents(5)),
              CalendarMonth(6, year, getMonthEvents(6)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CalendarMonth(7, year, getMonthEvents(7)),
              CalendarMonth(8, year, getMonthEvents(8)),
              CalendarMonth(9, year, getMonthEvents(9)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CalendarMonth(10, year, getMonthEvents(10)),
              CalendarMonth(11, year, getMonthEvents(11)),
              CalendarMonth(12, year, getMonthEvents(12)),
            ],
          )
        ],
      ),
    );
  }
}

class CalendarMonth extends StatelessWidget {
  final int month;
  final int year;

  final events;

  CalendarMonth(this.month, this.year, this.events);

  final dateUtil = DateUtil();

  getDate() {
    var formatMonth = month.toString().length > 1 ? month : '0$month';
    return DateTime.parse('$year-$formatMonth-01 01:00:00');
  }

  monthCalendar() {
    var date = getDate();
    var days = dateUtil.daysInMonth(month, year);
    var week = date.weekday;

    List resultMonth = [];

    int weekCount = days ~/ 7;

    for (var i = 0; i < weekCount + 2; i++) {
      resultMonth.add([]);
    }

    int index = 0;
    int totalDays = days + week - 1;
    for (var i = 0; i < totalDays; i++) {
      if (i % 7 == 0) index = i ~/ 7;
      if (i >= week - 1) {
        resultMonth[index].add(i - week + 2);
      } else {
        resultMonth[index].add('');
      }
    }

    return resultMonth;
  }

  onBackToMonth(context, month) {
    Map data = {'month': month, 'year': year};
    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    var list = monthCalendar();
    var date = getDate();
    String monthName = DateFormat.MMMM().format(date);

    return Container(
      width: 130,
      height: 150,
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 12),
        onPressed: () {
          onBackToMonth(context, month);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text('$monthName',
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600))),
            ),
            for (var week in list)
              Container(
                height: 18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        for (var day in week)
                          Container(
                              alignment: Alignment.center,
                              width: 15,
                              child: Text(day.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: events.contains(day)
                                              ? Colors.orange
                                              : Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600)))),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    )
                  ],
                ),
              ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
