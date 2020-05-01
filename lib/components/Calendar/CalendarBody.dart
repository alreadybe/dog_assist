import 'package:flutter/material.dart';

import './DayItem.dart';

class CalendarBody extends StatefulWidget {
  final days;

  CalendarBody(this.days);

  @override
  State<StatefulWidget> createState() {
    return _CalendarBodyState(days);
  }
}

class _CalendarBodyState extends State<CalendarBody> {
  final days;

  mapedDates(days) {
    var result = [];
    for (var i = 0; i < days; i++) {
      result.add({"day": i + 1, "active": false});
    }

    return result;
  }

  _CalendarBodyState(this.days);

  double stepPersent(days) => (days / 158);

  @override
  Widget build(BuildContext context) {
    double step = stepPersent(days);

    var dates = mapedDates(days);

    return Stack(children: <Widget>[
      Container(
        width: 370,
        height: 370,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 170,
          height: 170,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('10.04.2020'),
              SizedBox(
                height: 10,
              ),
              Text('Notes about this date')
            ],
          ),
        ),
      ),
      for (var item in dates)
        DayItem(
            item["day"].toString(), item["active"], step * item["day"] + 23.7)
    ]);
  }
}
