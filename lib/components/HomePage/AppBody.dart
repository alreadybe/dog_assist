import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';

class AppBody extends StatelessWidget {
  final soonEvents;
  final showNotif;

  AppBody(this.soonEvents, this.showNotif);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          soonEvents.length > 0
              ? FeedBody(soonEvents, showNotif)
              : Container(
                  alignment: Alignment.center,
                  width: 390,
                  height: 60,
                  color: Colors.black54,
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  padding: EdgeInsets.all(10),
                  child: Text(S.of(context).noEvents,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200))),
                ),
        ],
      ),
    );
  }
}

class FeedBody extends StatelessWidget {
  final events;
  final showNotif;

  FeedBody(this.events, this.showNotif);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 180,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, int index) =>
              CalendarFeedWidget(events[index], showNotif)),
    );
  }
}

class CalendarFeedWidget extends StatelessWidget {
  final event;
  final showNotif;

  CalendarFeedWidget(this.event, this.showNotif);

  @override
  Widget build(BuildContext context) {
    String category = event["category"];

    var name;
    switch (category) {
      case 'vet':
        name = S.of(context).vet;
        break;
      case 'dhandler':
        name = S.of(context).dhandler;
        break;
      case 'fight':
        name = S.of(context).fight;
        break;
      case 'measuring':
        name = S.of(context).measuring;
        break;
      case 'mating':
        name = S.of(context).mating;
        break;
      default:
        name = category;
        break;
    }
    String eventName = event["note"].length > 0 ? name : '';
    String eventNote = eventName.length > 0 ? event["note"] : name;

    return Container(
        color: Colors.black54,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.all(10),
        // height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(eventName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w200))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(eventNote,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w200))),
                ],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 22,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {
                  showNotif(eventName, eventNote, event["date"]);
                },
              ),
            ),
          ],
        ));
  }
}
