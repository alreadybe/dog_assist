import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderBar extends StatelessWidget {
  final String routeTitle;
  final bool needBack;
  final bool settings;
  final onPress;

  HeaderBar(this.routeTitle, this.needBack, this.settings, this.onPress);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Leading(needBack),
      actions: <Widget>[Actions(settings, onPress)],
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
              ? Navigator.pop(context, 'refresh')
              : Navigator.pushNamed(context, '/profile');
        });
  }
}

class Actions extends StatefulWidget {
  final settings;
  final onPress;

  Actions(this.settings, this.onPress);

  @override
  State<StatefulWidget> createState() {
    return _ActionsState(settings, onPress);
  }
}

class _ActionsState extends State<Actions> {
  final settings;
  final onPress;

  _ActionsState(this.settings, this.onPress);

  @override
  Widget build(BuildContext context) {
    return settings
        ? Container(
            child: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              onPress();
            },
          ))
        : SizedBox();
  }
}
