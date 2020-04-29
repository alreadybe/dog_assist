import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container totalByMonth(monthName, monthTotal) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black87,
          blurRadius: 6.0,
          offset: Offset(0.0, 1.0), // shadow direction: bottom right
        )
      ],
    ),
    margin: const EdgeInsets.only(left: 30, right: 50, bottom: 10, top: 20),
    padding: const EdgeInsets.all(10),
    height: 80,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('$monthName:',
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400))),
        SizedBox(
          height: 5,
        ),
        Text('$monthTotal',
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600))),
      ],
    ),
  );
}
