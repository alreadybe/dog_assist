import 'package:flutter/material.dart';

List<Map> routes = [
  {
    'path': '/buylist',
    'icon': Icon(Icons.monetization_on),
  },
  {
    'path': '/calendar',
    'icon': Icon(Icons.event),
  },
  {
    'path': '/notes',
    'icon': Icon(Icons.note),
  },
  {
    'path': '/training',
    'icon': Icon(Icons.school),
  },
];

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          navigateButton(routes[0]['icon'], context, routes[0]['path']),
          navigateButton(routes[1]['icon'], context, routes[1]['path']),
          navigateButton(routes[2]['icon'], context, routes[2]['path']),
          navigateButton(routes[3]['icon'], context, routes[3]['path']),
        ],
      ),
    );
  }
}

IconButton navigateButton(icon, context, path) {
  return IconButton(
      icon: icon,
      iconSize: 38,
      color: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, path);
      });
}
