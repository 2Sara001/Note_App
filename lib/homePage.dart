import 'package:flutter/material.dart';
import 'homePage.dart';
import '../dp/notes_database.dart';
import 'editnote.dart';
import 'addNote.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NoteDatabase sqlDb = NoteDatabase();
  List notes = [];

  Future<List<Map>> displayNotes() async {
    List<Map> response = await sqlDb.getNotes("SELECT * FROM notes ");
    notes = response;
    setState(() {});
    throw ('none');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await displayNotes();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff1321E0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color(0xff1321E0),
                Colors.purple
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        onPressed: navigateSecondPage,
      ),
      body: notes.length == 0
          ? Container(
              margin: EdgeInsets.only(bottom: 100),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://i.pinimg.com/originals/68/f2/0b/68f20b0e1f80bb14274292f39df80bbc.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text(
                            'No Notes Yet',
                            style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'you have no task to do',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ))
                ],
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, i) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditNote(notes[i]['title'], notes[i]['description'], notes[i]['color'], notes[i]['id']))).then(onGoBack);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 1,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                    child: Container(
                                      height: 100,
                                      width: 10,
                                      color: notes[i]['color'] == 0
                                          ? Color(0xff1321E0)
                                          : notes[i]['color'] == 1
                                              ? Color(0xffFFFFFF)
                                              : notes[i]['color'] == 2
                                                  ? Color(0xffF28B81)
                                                  : notes[i]['color'] == 3
                                                      ? Color(0xffF7BD02)
                                                      : notes[i]['color'] == 4
                                                          ? Color(0xffFBF476)
                                                          : notes[i]['color'] == 5
                                                              ? Color(0xffCDFF90)
                                                              : notes[i]['color'] == 6
                                                                  ? Color(0xffA7FEEB)
                                                                  : notes[i]['color'] == 7
                                                                      ? Color(0xffE6C9A9)
                                                                      : notes[i]['color'] == 8
                                                                          ? Color(0xffE9EAEE)
                                                                          : Color(0xffD7AEFC),
                                    ))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 300,
                                    child: Text(
                                      '${notes[i]['title']}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: const TextStyle(color: Color.fromARGB(255, 19, 33, 224), fontSize: 24, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    margin: const EdgeInsets.only(top: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${notes[i]['description']}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  FutureOr onGoBack(dynamic value) {
    displayNotes();
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => addNote());
    Navigator.push(context, route).then(onGoBack);
  }
}
