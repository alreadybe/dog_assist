import 'dart:math';

import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  final date;
  final active;

  final step;

  DayItem(this.date, this.active, this.step);

  double percentageToRadians(double percentage) =>
      ((2 * pi * percentage) / 100);

  Offset radiansToCoordinates(Offset center, double radians, double radius) {
    var dx = center.dx + radius * cos(radians);
    var dy = center.dy + radius * sin(radians);
    return Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    Offset center = Offset(165, 165);
    double radius = 330.0 / 2;

    Offset positions = radiansToCoordinates(center, step, radius);

    print(radius);

    return Positioned(
      top: positions.dy,
      left: positions.dx,
      child: Container(
        width: active ? 40 : 30,
        height: active ? 40 : 30,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: active ? Colors.orangeAccent : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Text(date),
      ),
    );
  }
}
