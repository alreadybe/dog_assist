import 'dart:io';

import 'package:DogAssistant/utils/localstore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  File _image;

  String name;
  String age;
  String breed;

  var update;

  var averageData;

  loadAchievements() async {
    //var allData = await readData('achievements') ?? [];
    //TODO: implements achievments load
  }

  loadPetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileName = prefs.getString('profileName') ?? null;
    String profileAge = prefs.getString('profileAge') ?? null;
    String profileBreed = prefs.getString('profileBreed') ?? null;

    setState(() {
      name = profileName;
      age = profileAge;
      breed = profileBreed;
    });
  }

  loadProfilePic() async {
    var image = await readProfileImageAsBase64String();
    setState(() {
      _image = image;
    });
  }

  editProfile() async {
    await Navigator.pushNamed(context, '/editprofile');
    await loadPetData();
    await loadProfilePic();
  }

  @override
  void initState() {
    _image = null;

    loadProfilePic();
    loadPetData();
    loadAchievements();

    super.initState();
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
                child: HeaderBar(
                    S.of(context).profile, true, 'editProfile', editProfile),
                preferredSize: Size(double.infinity, kToolbarHeight)),
            body: _profileBody()));
  }

  Widget _profileBody() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 30,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _image == null ? _emptyPic() : _profilePic(_image),
                    _petInfo(),
                  ],
                ),
                _petBody(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profilePic(image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
          shape: BoxShape.circle),
    );
  }

  Widget _emptyPic() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: 120,
      height: 120,
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: Icon(
        Icons.pets,
        size: 72,
        color: Colors.white70,
      ),
    );
  }

  Widget _petInfo() {
    return Container(
      width: 150,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name != null ? '$name' : '',
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w600))),
          Text(age != null ? '$age' : '',
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600))),
          Text(breed != null ? '$breed' : '',
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }

  Widget _petBody() {
    return Container(
      width: 350,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    S.of(context).achievements,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Container(
                    width: 350,
                    height: 470,
                    margin: EdgeInsets.only(top: 10),
                    child: averageData != null && averageData.length > 0
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: averageData.length,
                            itemBuilder: (context, int index) => _achiveItem(
                                averageData[index]["name"],
                                averageData[index]["rate"]),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 150),
                            child: Text(S.of(context).noachieve,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w200)))))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _achiveItem(name, rate) {
    return Container(
        height: 40,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(name,
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w200))),
            Container(
                child: Row(
              children: <Widget>[
                Icon(Icons.star,
                    color: rate >= 1 ? Colors.orange : Colors.white),
                Icon(Icons.star,
                    color: rate >= 2 ? Colors.orange : Colors.white),
                Icon(Icons.star,
                    color: rate >= 3 ? Colors.orange : Colors.white),
                Icon(Icons.star,
                    color: rate >= 4 ? Colors.orange : Colors.white),
                Icon(Icons.star,
                    color: rate >= 5 ? Colors.orange : Colors.white),
              ],
            )),
          ],
        ));
  }
}
