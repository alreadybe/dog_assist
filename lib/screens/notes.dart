import 'package:DogAssistant/utils/localstore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  bool isOpen;
  bool isEdit;

  String textNote;
  String idEditNote;

  loadNotes() async {
    var data = await readData('notes') ?? [];

    setState(() {
      notes = data;
    });
  }

  _writeNote() async {
    if (textNote != null && textNote.length > 0) {
      var note = {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "date": DateTime.now().toString(),
        "note": textNote,
      };

      await writeData(note, 'notes');
      setState(() {
        isOpen = false;
        textNote = null;
      });
      controllerNote.clear();

      loadNotes();
    }
    return;
  }

  _editExNote(id) async {
    if (id == null) return;
    if (textNote != null && textNote.length > 0) {
      var note = {
        'id': id,
        "date": DateTime.now().toString(),
        "note": textNote,
      };

      await editNotes(note, id);

      setState(() {
        isOpen = false;
        isEdit = false;
        idEditNote = null;

        textNote = null;
      });
      controllerNote.clear();

      loadNotes();
    }
    return;
  }

  _deleteExNote(id) async {
    await deleteNotes(id);

    setState(() {
      idEditNote = null;
      isOpen = false;
    });
    loadNotes();

    return;
  }

  TextEditingController controllerNote;

  @override
  void initState() {
    loadNotes();

    textNote = null;

    isOpen = false;
    isEdit = false;

    controllerNote = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controllerNote.dispose();

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
              child: isOpen
                  ? _editNoteHeader()
                  : HeaderBar(S.of(context).notes, true, null, null),
              preferredSize: Size(double.infinity, kToolbarHeight)),
          body: Container(
            child: isOpen ? _editNote() : _allNotes(),
          ),
          bottomNavigationBar: !isOpen
              ? Container(
                  child: _addButton(),
                )
              : SizedBox(),
        ));
  }

  Widget _editNoteHeader() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            isOpen = false;
            idEditNote = null;
            textNote = null;
          });
          controllerNote.clear();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          iconSize: 28,
          onPressed: () {
            _deleteExNote(idEditNote);
          },
        ),
        IconButton(
            icon: Icon(Icons.done),
            iconSize: 32,
            onPressed: () {
              isEdit ? _editExNote(idEditNote) : _writeNote();
            })
      ],
      backgroundColor: Colors.transparent,
      elevation: 1,
    );
  }

  Widget _allNotes() {
    return Container(
        child: notes != null && notes.length > 0
            ? GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(notes.length, (index) {
                  return _noteItem(notes[index]);
                }))
            : Center(
                child: Text(S.of(context).noNotes,
                    style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400)))));
  }

  Widget _noteItem(note) {
    return GestureDetector(
      onTap: () {
        setState(() {
          textNote = note['note'];
          controllerNote.text = textNote;
          idEditNote = note['id'].toString();
          isEdit = true;
          isOpen = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 5, left: 10, right: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Color(0xFF232323)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 120,
              child: Text(note["note"],
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))),
            ),
            Text(
                DateFormat.yMMMMEEEEd()
                    .format(DateTime.parse(note['date']))
                    .toString(),
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w200))),
          ],
        ),
      ),
    );
  }

  Widget _editNote() {
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
          controller: controllerNote,
          onChanged: (String value) async {
            setState(() {
              textNote = value;
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
                isOpen = true;
              });
            }));
  }
}
