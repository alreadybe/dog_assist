import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/calendar.dart';

import '../../generated/l10n.dart';

class AddEvent extends StatefulWidget {
  final CalendarState parent;
  final name;

  AddEvent(this.name, this.parent);

  @override
  State<StatefulWidget> createState() {
    return _AddEventState(name, parent);
  }
}

class _AddEventState extends State<AddEvent> {
  final CalendarState parent;
  final name;

  _AddEventState(this.name, this.parent);

  TextEditingController _controllerName;
  TextEditingController _controllerNote;

  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerNote = TextEditingController();

    super.initState();
  }

  void dispose() {
    _controllerName.dispose();
    _controllerNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6.0,
              offset: Offset(0.0, 1.0), // shadow direction: bottom right
            )
          ],
          color: Color(0xFF171717),
        ),
        width: 390,
        height: 300,
        child: Column(
          children: <Widget>[
            Container(
              width: 370,
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  this.parent.filter == 'other'
                      ? Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 280,
                          child: TextField(
                              cursorWidth: 2,
                              cursorColor: Colors.black54,
                              style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                  fillColor: Colors.orangeAccent,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: S.of(context).enterEventName,
                                  hintStyle: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight
                                              .w200)) //S.of(contex).enterEventName,
                                  ),
                              controller: _controllerName,
                              onChanged: (String value) async {
                                this.parent.setState(() {
                                  this.parent.eventName = value;
                                });
                              }),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(this.parent.filterName,
                              style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w600))),
                        ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      iconSize: 42,
                      onPressed: () {
                        this.parent.setState(() {
                          this.parent.showModal = false;
                          this.parent.addActive = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 350,
              height: 165,
              margin: EdgeInsets.only(top: 40),
              child: TextField(
                  expands: true,
                  cursorWidth: 2,
                  cursorColor: Colors.black54,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  decoration: InputDecoration(
                      fillColor: Colors.orangeAccent,
                      filled: true,
                      border: InputBorder.none,
                      hintText: S.of(context).enterEventNote,
                      hintStyle: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight
                                  .w400)) //S.of(contex).enterEventName,
                      ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controllerNote,
                  onChanged: (String value) async {
                    this.parent.setState(() {
                      this.parent.eventNote = value;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
