import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';

class FilterBar extends StatelessWidget {
  final filter;
  final setFilter;

  FilterBar(this.filter, this.setFilter);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          FilterIcon(S.of(context).vet, 'vet', filter, Icons.local_pharmacy,
              setFilter),
          FilterIcon(S.of(context).dhandler, 'dhandler', filter,
              Icons.person_pin, setFilter),
          FilterIcon(
              S.of(context).fight, 'fight', filter, Icons.leak_add, setFilter),
          FilterIcon(S.of(context).measuring, 'measuring', filter,
              Icons.open_with, setFilter),
          FilterIcon(S.of(context).mating, 'mating', filter,
              Icons.favorite_border, setFilter),
          FilterIcon(
              S.of(context).other, 'other', filter, Icons.blur_on, setFilter),
        ],
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  final text;
  final name;
  final filter;
  final icon;

  final setFilter;

  FilterIcon(this.text, this.name, this.filter, this.icon, this.setFilter);

  @override
  Widget build(BuildContext context) {
    var active = name == filter;
    var color = active ? Colors.green : Colors.white;
    return Container(
      width: 100,
      child: FlatButton(
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: color,
              size: 26,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$text',
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w200)),
            )
          ],
        ),
        onPressed: () {
          setFilter(name, text);
        },
      ),
    );
  }
}
