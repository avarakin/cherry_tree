import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;


  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ExpansionTile(
        key: PageStorageKey<Entry>(root),
        title: Text(root.title),
        children: [Text("agasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsd" )],
      );


//      return Card(child: Text(root.title + "agasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsd" ));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}



abstract class Dao<T> {
  //queries
  String get createTableQuery;

  //abstract mapping methods
  T fromMap(Map<String, dynamic> query);
  List<T> fromList(List<Map<String,dynamic>> query);
  Map<String, dynamic> toMap(T object);
}


class Note {
  int id;
  String title;
  String description;

  Note(this.title, this.description);
}

class NoteDao implements Dao<Note> {
  final tableName = 'notes';
  final columnId = 'id';
  final _columnTitle = 'title';
  final _columnDescription = 'description';


  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
          " $_columnTitle TEXT,"
          " $_columnDescription TEXT)";

  @override
  Note fromMap(Map<String, dynamic> query) {
    Note note = Note();
    note.id = query[columnId];
    note.title = query[_columnTitle];
    note.description = query[_columnDescription];
    return note;
  }

  @override
  Map<String, dynamic> toMap(Note object) {
    return <String, dynamic>{
      _columnTitle: object.title,
      _columnDescription: object.description
    };
  }

  @override
  List<Note> fromList(List<Map<String,dynamic>> query) {
    List<Note> notes = List<Note>();
    for (Map map in query) {
      notes.add(fromMap(map));
    }
    return notes;
  }
}


class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, ‘todo_app.db’);

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(NoteDao().createTableQuery);
        });
  }
}


class NotesDatabaseRepository implements NotesRepository {
  final dao = NoteDao();

  @override
  DatabaseProvider databaseProvider;

  NotesDatabaseRepository(this.databaseProvider);

  @override
  Future<Note> insert(Note note) async {
    final db = await databaseProvider.db();
    note.id = await db.insert(dao.tableName, dao.toMap(note));
    return note;
  }

  @override
  Future<Note> delete(Note note) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [note.id]);
    return note;
  }

  @override
  Future<Note> update(Note note) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(note),
        where: dao.columnId + " = ?", whereArgs: [note.id]);
    return note;
  }

  @override
  Future<List<Note>> getNotes() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}


void main() {

/*
  createDatabase() async {

    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }
*/
  runApp(ExpansionTileSample());
}