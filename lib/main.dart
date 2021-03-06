import 'package:flutter/material.dart';
import 'DAO.dart';


class ExpansionTileSample extends StatelessWidget {

  final List<Entry> data;

  ExpansionTileSample(this.data);


  @override
  Widget build (BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.note);

  final Note note;
  List<Entry> children = List<Entry>();

  bool add(Entry item) {
    if(note.id == item.note.parent) {
      children.add(item);
      return true;
    } else {
      for (Entry i in children) {
        if(i.add(item))
          return true;
      }
      return false;
    }
  }

}


// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;


  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ExpansionTile(
        key: PageStorageKey<Entry>(root),
        title: Text(root.note.title),
        children: [Text(root.note.description)],
      );

    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.note.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}


void main() {

//  final List<Entry> data = List<Entry>();

  Note rootNote = Note();
  rootNote.id = 0;

  Entry rootEntry = Entry(rootNote);

  var db = DatabaseProvider.get;


  var repo = NotesDatabaseRepository(db);
  repo.getNotes().then((notes) {
    print("reading...");
    for( var item in notes ) {
      print(item.id.toString() + " " + item.parent.toString() + " " + item.title);

      rootEntry.add(Entry(item));
    }
    runApp(ExpansionTileSample(rootEntry.children));
  }, onError: (e) {
    print(e);
  });


}

