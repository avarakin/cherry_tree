import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

abstract class Dao<T> {


  //abstract mapping methods
  T fromMap(Map<String, dynamic> query);
  List<T> fromList(List<Map<String,dynamic>> query);
  Map<String, dynamic> toMap(T object);
}


class Note {
  int id;
  String title;
  String description;

  Note();
}

class NoteDao implements Dao<Note> {
  final tableName = 'node';
  final columnId = 'node_id';
  final _columnTitle = 'name';
  final _columnDescription = 'txt';


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
    String path = join('/mnt/sdcard/Android/data/com.dropbox.android/files/u17068703/scratch', 'CT.ctb');
    _db = await openDatabase(path,  readOnly: true );
    print("Opened database");
  }
}

abstract class NotesRepository {
  DatabaseProvider databaseProvider;

  Future<Note> insert(Note note);

  Future<Note> update(Note note);

  Future<Note> delete(Note note);

  Future<List<Note>> getNotes();
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
