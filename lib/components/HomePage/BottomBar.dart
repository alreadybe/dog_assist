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
  final goToPage;

  BottomBar(this.goToPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          navigateButton(
              routes[0]['icon'], context, routes[0]['path'], goToPage),
          navigateButton(
              routes[1]['icon'], context, routes[1]['path'], goToPage),
          navigateButton(
              routes[2]['icon'], context, routes[2]['path'], goToPage),
          navigateButton(
              routes[3]['icon'], context, routes[3]['path'], goToPage),
        ],
      ),
    );
  }
}

IconButton navigateButton(icon, context, path, goToPage) {
  return IconButton(
      icon: icon,
      iconSize: 38,
      color: Colors.white,
      onPressed: () {
        goToPage(context, path);
      });
}
