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
  Entry(this.note, [this.children = const <Entry>[]]);

  final Note note;
  final List<Entry> children;
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

  final List<Entry> data = List<Entry>();
  var db = DatabaseProvider.get;


  var repo = NotesDatabaseRepository(db);
  repo.getNotes().then((notes) {
    print("reading...");
    for( final item in notes ) {
      print(item.title);
      data.add(Entry(item));
    }

    print("Items" + data.toString());
    runApp(ExpansionTileSample(data));
  }, onError: (e) {
    print(e);
  });


}

