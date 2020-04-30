import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderBar extends StatelessWidget {
  final String routeTitle;
  final bool needBack;

  HeaderBar(this.routeTitle, this.needBack);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Leading(needBack),
      actions: <Widget>[
        if (routeTitle != 'Setting')
          Container(
              child: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )),
      ],
      title: Text(routeTitle,
          style: GoogleFonts.poiretOne(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold))),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 1,
    );
  }
}

class Leading extends StatelessWidget {
  final bool needBack;
  Leading(this.needBack);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(needBack ? Icons.arrow_back : Icons.pets),
        iconSize: 26,
        color: Colors.white,
        onPressed: () {
          needBack
              ? Navigator.pop(context)
              : Navigator.pushNamed(context, '/profile');
        });
  }
}
