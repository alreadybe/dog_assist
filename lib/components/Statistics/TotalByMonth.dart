import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalByMonth extends StatefulWidget {
  final monthData;

  TotalByMonth(this.monthData);
  @override
  State<StatefulWidget> createState() {
    return TotalByMonthState(monthData);
  }
}

class TotalByMonthState extends State<TotalByMonth> {
  final monthData;
  var open;

  TotalByMonthState(this.monthData);

  @override
  void initState() {
    open = true;
    print('initialse');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = monthData['name'];
    var total = monthData['total'];

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
      height: open ? 280 : 80,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("$name:",
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400))),
                  SizedBox(
                    height: 5,
                  ),
                  Text("$total",
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600))),
                ],
              ),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      open = !open;
                    });
                  },
                ),
              )
            ],
          ),
          if (open) extendData(monthData),
        ],
      ),
    );
  }
}

Container extendData(data) {
  var eat = data['eat'].toString();
  var toys = data['toys'].toString();
  var train = data['train'].toString();
  var health = data['health'].toString();
  var hygiene = data['hygiene'].toString();
  var other = data['other'].toString();

  return Container(
    alignment: Alignment.centerLeft,
    height: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        dataItem('Eat', eat, Icons.restaurant),
        dataItem('Toys', toys, Icons.toys),
        dataItem('Training', train, Icons.school),
        dataItem('Health', health, Icons.local_hospital),
        dataItem('Hygiene', hygiene, Icons.pool),
        dataItem('Other', other, Icons.blur_on),
      ],
    ),
  );
}

Row dataItem(name, total, icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(icon, color: Colors.white),
      SizedBox(
        width: 10,
      ),
      Text(
        '$name: $total',
        textAlign: TextAlign.left,
        style: GoogleFonts.rubik(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w200)),
      ),
    ],
  );
}
