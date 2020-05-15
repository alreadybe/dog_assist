import 'package:DogAssistant/utils/localstore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';

import '../components/HeaderBar.dart';

class Notes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotesState();
  }
}

class _NotesState extends State<Notes> {
  var notes;
  bool addOpen;

  String noteToAdd;

  loadNotes() async {
    var data = await readData('notes') ?? [];

    print(data);

    setState(() {
      notes = data;
    });
  }

  _writeNote() async {
    if (noteToAdd != null && noteToAdd.length > 0) {
      var note = {
        "date": DateTime.now().toString(),
        "note": noteToAdd,
      };

      await writeData(note, 'notes');
    }
    return;
  }

  TextEditingController _controllerNote;

  @override
  void initState() {
    loadNotes();

    addOpen = false;

    _controllerNote = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controllerNote.dispose();

    super.dispose();
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
              child: HeaderBar(S.of(context).notes, true, null, null),
              preferredSize: Size(double.infinity, kToolbarHeight)),
          body: Container(
            child: addOpen ? _addFields() : _notesBody(),
          ),
          bottomNavigationBar: !addOpen
              ? Container(
                  child: _addButton(),
                )
              : SizedBox(),
        ));
  }

  Widget _notesBody() {
    return Container(
        child: notes != null && notes.length > 0
            ? ListView.builder(
                itemBuilder: (context, int index) =>
                    _noteItem(notes[index]["note"]))
            : Text('No notes'));
  }

  Widget _noteItem(note) {
    return Container(
      child: Text(note),
    );
  }

  Widget _addFields() {
    return Container(
      margin: EdgeInsets.all(20),
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
                      fontWeight:
                          FontWeight.w400)) //S.of(contex).enterEventName,
              ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _controllerNote,
          onChanged: (String value) async {
            setState(() {
              noteToAdd = value;
            });
          }),
    );
  }

  Widget _addButton() {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: IconButton(
            color: Colors.green,
            iconSize: 52,
            icon: Icon(Icons.add_circle),
            onPressed: () {
              setState(() {
                addOpen = true;
              });
            }));
  }
}
