import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/localstore.dart';
import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

import '../components/Statistics/TotalByMonth.dart';

class Statistics extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatisticsState();
  }
}

class _StatisticsState extends State<Statistics> {
  List<Map> monthesList = [];
  var data;

  @override
  void initState() {
    getData();
    super.initState();
  }

  formatData(month) {
    double total = 0;
    double eat = 0;
    double toys = 0;
    double train = 0;
    double health = 0;
    double hygiene = 0;
    double other = 0;

    var monthData = data
        .where((element) =>
            DateFormat.MMMM().format(DateTime.parse(element['time'])) ==
            month['month'])
        .toList();

    monthData.forEach((item) {
      total = total + double.parse(item['count']);
      switch (item['category']) {
        case 'eat':
          eat = eat + double.parse(item['count']);
          break;
        case 'toys':
          toys = toys + double.parse(item['count']);
          break;
        case 'train':
          train = train + double.parse(item['count']);
          break;
        case 'health':
          health = health + double.parse(item['count']);
          break;
        case 'hygiene':
          hygiene = hygiene + double.parse(item['count']);
          break;
        case 'other':
          other = other + double.parse(item['count']);
          break;
      }
    });

    var result = {
      'name': month['month'],
      'total': total,
      'eat': eat,
      'toys': toys,
      'train': train,
      'health': health,
      'hygiene': hygiene,
      'other': other
    };

    return result;
  }

  getData() async {
    var fetchData = await readData('spends');

    fetchData.forEach((obj) {
      var objMonth = DateFormat.MMMM().format(DateTime.parse(obj['time']));
      var isNewMonth = monthesList
          .where((month) => month['month'] == objMonth)
          .toList()
          .isEmpty;

      if (isNewMonth) monthesList.add({"month": objMonth, "time": obj['time']});
    });

    monthesList.sort((a, b) => a["time"].compareTo(b["time"]));

    setState(() {
      data = fetchData;
    });
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
                child: HeaderBar(S.of(context).statistics, true, null, null),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: monthesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TotalByMonth(formatData(monthesList[index]));
                },
              ),
            )));
  }
}
