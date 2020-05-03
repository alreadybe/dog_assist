import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../../screens/calendar.dart';

class DayItem extends StatelessWidget {
  final CalendarState parent;

  final date;
  final step;
  final selectedDay;

  DayItem(this.date, this.step, this.selectedDay, this.parent);

  double percentageToRadians(double percentage) =>
      ((2 * pi * percentage) / 100);

  Offset radiansToCoordinates(Offset center, double radians, double radius) {
    var dx = center.dx + radius * cos(radians);
    var dy = center.dy + radius * sin(radians);
    return Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    Offset center = Offset(168, 175);
    double radius = 355.0 / 2;

    var day = date["day"].toString();
    var active = date["active"];
    var currentStep = step * date["day"] + 23.7;

    var selected = selectedDay == date["day"];

    Offset positions = radiansToCoordinates(center, currentStep, radius);

    getColor() {
      if (active) return Colors.orange;
      if (selected) return Colors.green;
      return Colors.transparent;
    }

    return Positioned(
      top: positions.dy,
      left: positions.dx,
      child: Container(
        width: 42,
        height: 30,
        // alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: getColor(),
          shape: BoxShape.circle,
        ),
        child: FlatButton(
          shape: CircleBorder(),
          child: Text(
            day,
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w400)),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            this.parent.setState(() {
              this.parent.selectedDay = date['day'];
            });
          },
        ),
      ),
    );
  }
}
