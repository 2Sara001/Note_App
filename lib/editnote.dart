import 'package:flutter/material.dart';
import 'homePage.dart';
import '../dp/notes_database.dart';
import 'editnote.dart';
import 'addNote.dart';
import 'dart:async';

class EditNote extends StatefulWidget {
  final title;
  final description;
  final color;
  final id;

  EditNote(this.title, this.description, this.color, this.id);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  NoteDatabase sqlDb = NoteDatabase();
  List notes = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  int? color;

  @override
  void initState() {
    title.text = widget.title;
    description.text = widget.description;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color == 0
            ? Color(0xff1321E0)
            : color == 1
                ? Color(0xffFFFFFF)
                : color == 2
                    ? Color(0xffF28B81)
                    : color == 3
                        ? Color(0xffF7BD02)
                        : color == 4
                            ? Color(0xffFBF476)
                            : color == 5
                                ? Color(0xffCDFF90)
                                : color == 6
                                    ? Color(0xffA7FEEB)
                                    : color == 7
                                        ? Color(0xffE6C9A9)
                                        : color == 8
                                            ? Color(0xffE9EAEE)
                                            : Color(0xffD7AEFC),
        title: const Text('Edit Note'),
        actions: [
          IconButton(
              onPressed: () async {
                Future buildbottom = await buildbottomsheet(context);
              },
              icon: const Icon(Icons.more_vert)),
          IconButton(
              onPressed: () async {
                int response = await sqlDb.updateNote('''
                      UPDATE notes SET 
                       title = "${title.text}" ,
                        description = "${description.text}" ,
                        color = ${color}
                         WHERE id = ${widget.id}

                        ''');
                if (response > 0) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(30, 30, 30, 2),
              child: TextFormField(
                controller: title,
                decoration: const InputDecoration(border: InputBorder.none, hintText: 'Type Something...', hintStyle: TextStyle(fontSize: 22, color: Color(0xff1321E0))),
                style: TextStyle(color: Color(0xff1321E0), fontSize: 22),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(hintText: 'Type Something...', hintStyle: TextStyle(fontSize: 18, color: Colors.grey), border: InputBorder.none),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildbottomsheet(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            color: color == 0
                ? Color(0xff1321E0)
                : color == 1
                    ? Color(0xffFFFFFF)
                    : color == 2
                        ? Color(0xffF28B81)
                        : color == 3
                            ? Color(0xffF7BD02)
                            : color == 4
                                ? Color(0xffFBF476)
                                : color == 5
                                    ? Color(0xffCDFF90)
                                    : color == 6
                                        ? Color(0xffA7FEEB)
                                        : color == 7
                                            ? Color(0xffE6C9A9)
                                            : color == 8
                                                ? Color(0xffE9EAEE)
                                                : Color(0xffD7AEFC),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: Column(
                children: [
                  Row1(
                    'Share with your frinds',
                    const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 22,
                          child: IconButton(
                              onPressed: () async {
                                int count = 0;
                                int response = await sqlDb.deleteNote("DELETE FROM notes WHERE id = ${widget.id} ");
                                if (response > 0) {
                                  setState(() {});
                                  Navigator.of(context).popUntil((_) => count++ >= 2);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      var title = widget.title;
                      var description = widget.description;
                      var color = widget.color;

                      int response = await sqlDb.insertNote('''
                          INSERT INTO notes ( title , description , color  )
                         VALUES("${title}","${description}" , "${color}")
                         ''');
                      if (response > 0) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Row1(
                      'Duplicade',
                      const Icon(
                        Icons.copy_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _colorPalette(),
                ],
              ),
            ),
          );
        });
  }

  Container Row1(String t, Icon i) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 22,
              child: i,
            ),
          ),
          Text(
            t,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _colorPalette() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
          children: List<Widget>.generate(
        7,
        (index) => InkWell(
          onTap: () {
            setState(() {
              color = index;
            });
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                child: color == index
                    ? const Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.black,
                      )
                    : null,
                backgroundColor: index == 0
                    ? Color(0xff1321E0)
                    : index == 1
                        ? Color(0xffFFFFFF)
                        : index == 2
                            ? Color(0xffF28B81)
                            : index == 3
                                ? Color(0xffF7BD02)
                                : index == 4
                                    ? Color(0xffFBF476)
                                    : index == 5
                                        ? Color(0xffCDFF90)
                                        : index == 6
                                            ? Color(0xffA7FEEB)
                                            : index == 7
                                                ? Color(0xffE6C9A9)
                                                : index == 8
                                                    ? Color(0xffE9EAEE)
                                                    : Color(0xffD7AEFC),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
