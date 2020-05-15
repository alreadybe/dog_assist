import 'dart:io';

import 'package:DogAssistant/utils/localstore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';
import 'package:simple_image_crop/simple_image_crop.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class ProfileEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileEditState();
  }
}

class _ProfileEditState extends State<ProfileEdit> {
  final cropKey = GlobalKey<ImgCropState>();
  File _image;
  File _sample;

  String oldName;
  String oldAge;
  String oldBreed;

  Future<void> _openImage(source) async {
    final file = await ImagePicker.pickImage(source: source);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    setState(() {
      _sample = sample;
      _image = file;
    });
  }

  loadPetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileName = prefs.getString('profileName') ?? null;
    String profileAge = prefs.getString('profileAge') ?? null;
    String profileBreed = prefs.getString('profileBreed') ?? null;

    setState(() {
      oldName = profileName;
      oldAge = profileAge;
      oldBreed = profileBreed;
    });
  }

  loadProfilePic() async {
    var image = await readProfileImageAsBase64String();
    setState(() {
      _image = image;
    });
  }

  Future<void> _askedToSource() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(S.of(context).selectsource,
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600))),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  _openImage(ImageSource.camera);
                  Navigator.pop(context, true);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(S.of(context).camera,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  _openImage(ImageSource.gallery);
                  Navigator.pop(context, true);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(S.of(context).gallery,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      return;
    }

    final sample = await ImageCrop.sampleImage(
      file: _image,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    setState(() {
      _image = file;
      _sample = null;
    });
  }

  Future<void> _saveChanged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (name != null && name.length > 0) prefs.setString('profileName', name);
    if (age != null && age.length > 0) prefs.setString('profileAge', age);
    if (breed != null && breed.length > 0)
      prefs.setString('profileBreed', breed);

    await writeProfileImageAsBase64String(_image);

    Navigator.pop(context);
  }

  TextEditingController _controllerName;
  TextEditingController _controllerAge;
  TextEditingController _controllerBreed;

  String name;
  String age;
  String breed;

  @override
  void initState() {
    loadProfilePic();
    loadPetData();

    _controllerName = TextEditingController();
    _controllerAge = TextEditingController();
    _controllerBreed = TextEditingController();

    super.initState();
  }

  void dispose() {
    _controllerName.dispose();
    _controllerAge.dispose();
    _controllerBreed.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: _sample != null
            ? _croppingImage()
            : Scaffold(
                backgroundColor: Colors.black38,
                appBar: PreferredSize(
                    child: HeaderBar(S.of(context).profile, true, null, null),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image == null ? _emptyPic() : _profilePic(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    S.of(context).setpic,
                    style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w200)),
                  ),
                ),
                _inputFields(),
                _saveButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _croppingImage() {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ImgCrop(
                  key: cropKey,
                  chipRadius: 60,
                  chipShape: 'circle',
                  maximumScale: 5,
                  image: FileImage(_image)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      S.of(context).apply,
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () => _cropImage(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profilePic() {
    return FlatButton(
        onPressed: () {
          _askedToSource();
        },
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: FileImage(_image), fit: BoxFit.cover),
              shape: BoxShape.circle),
        ));
  }

  Widget _emptyPic() {
    return FlatButton(
      onPressed: () {
        _askedToSource();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        child: Icon(
          Icons.photo_camera,
          size: 42,
        ),
      ),
    );
  }

  Widget _inputFields() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: TextField(
                  keyboardType: TextInputType.text,
                  cursorWidth: 2,
                  cursorColor: Colors.black54,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText: oldName != null && oldName.length > 0
                          ? oldName
                          : S.of(context).setname,
                      hintStyle: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w200))),
                  controller: _controllerName,
                  onChanged: (String value) async {
                    setState(() {
                      name = value;
                    });
                  })),
          Container(
              child: TextField(
                  keyboardType: TextInputType.number,
                  cursorWidth: 2,
                  cursorColor: Colors.black54,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText: oldAge != null && oldAge.length > 0
                          ? oldAge
                          : S.of(context).setage,
                      hintStyle: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w200))),
                  controller: _controllerAge,
                  onChanged: (String value) async {
                    setState(() {
                      age = value;
                    });
                  })),
          Container(
              child: TextField(
                  keyboardType: TextInputType.text,
                  cursorWidth: 2,
                  cursorColor: Colors.black54,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText: oldBreed != null && oldBreed.length > 0
                          ? oldBreed
                          : S.of(context).setbreed,
                      hintStyle: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w200))),
                  controller: _controllerBreed,
                  onChanged: (String value) async {
                    setState(() {
                      breed = value;
                    });
                  }))
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      padding: EdgeInsets.all(20),
      child: RaisedButton(
        color: Colors.orange,
        onPressed: () {
          _saveChanged();
        },
        child: Text(
          S.of(context).save,
          style: GoogleFonts.rubik(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
