import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/localstore.dart';

import '../components/HeaderBar.dart';

class BuyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuyListState();
  }
}

class _BuyListState extends State<BuyList> {
  double currentMonthTotal = 0;
  String category = 'Other';

  String inputField;

  DateTime today = DateTime.now();

  @override
  void initState() {
    inputField = '0';
    super.initState();
  }

  Container goToStatistics() {
    return Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(top: 5, right: 10),
        child: IconButton(
            icon: Icon(
              Icons.equalizer,
              size: 42,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/statistics');
            }));
  }

  Container selectCategory() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 70,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            categoryButton('Eat', Icons.restaurant),
            categoryButton('Toys', Icons.toys),
            categoryButton('Training', Icons.school),
            categoryButton('Health', Icons.local_hospital),
            categoryButton('Hygiene', Icons.pool),
            categoryButton('Other', Icons.blur_on),
          ],
        ),
      ),
    );
  }

  Container categoryButton(name, icon) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              icon,
              color: name == category ? Colors.greenAccent : Colors.white,
            ),
            Text(
              name,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      color:
                          name == category ? Colors.greenAccent : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w200)),
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            category = name;
          });
        },
      ),
    );
  }

  Container sumField(sum) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 200,
      alignment: Alignment.center,
      child: Text('$sum',
          style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w600))),
    );
  }

  Container clearButton() {
    return Container(
      width: 95,
      child: IconButton(
        color: Colors.red[300],
        icon: Icon(
          Icons.backspace,
          size: 34,
        ),
        onPressed: () {
          setState(() {
            if (inputField == '0') return;
            inputField = inputField.substring(0, inputField.length - 1);
            if (inputField.length == 0) inputField = '0';
          });
        },
      ),
    );
  }

  FlatButton confirmButton() {
    return FlatButton(
      child: Icon(
        Icons.add,
        size: 44,
        color: Colors.white,
      ),
      color: Colors.green,
      onPressed: () {
        setState(() {
          var data = {
            "count": inputField,
            "category": category,
            "time": DateTime.now().toString(),
          };
          writeData(data, 'spends');
          setState(() {
            inputField = '0';
          });
        });
      },
    );
  }

  FlatButton numberButton(num) {
    return FlatButton(
      child: Text('$num',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.w600))),
      onPressed: () {
        setState(() {
          if (inputField == '0') {
            inputField = num.toString();
            return;
          }
          inputField = inputField + num.toString();
        });
      },
    );
  }

  Container dotButton() {
    return Container(
      width: 97,
      child: FlatButton(
        child: Text('.',
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w600))),
        onPressed: () {
          setState(() {
            if (inputField.contains('.') == false && inputField.length > 0) {
              inputField = inputField + '.';
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.black38,
          appBar: PreferredSize(
              child: HeaderBar('Purchases', true),
              preferredSize: Size(double.infinity, kToolbarHeight)),
          body: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                goToStatistics(),
                sumField(inputField),
                selectCategory(),
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 320,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              numberButton(1),
                              numberButton(2),
                              numberButton(3),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              numberButton(4),
                              numberButton(5),
                              numberButton(6),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              numberButton(7),
                              numberButton(8),
                              numberButton(9),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              dotButton(),
                              numberButton(0),
                              clearButton(),
                            ],
                          )
                        ]))
              ])),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(left: 30, bottom: 20, right: 30),
            child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      confirmButton(),
                    ])),
          ),
        ));
  }
}
