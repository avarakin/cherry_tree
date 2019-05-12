/*
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

abstract class Persistable {
  static String getQuery() { return ""; }
  Persistable();
}


class Note  implements Persistable {
  int id;
  String title;
  String description;
  Note();

  @override
  static String getQuery() {
    return 'SELECT father_id, children.node_id, name, txt FROM children, node where children.node_id = node.node_id order by father_id, sequence';
  }
}

class NoteDao {
  final sql = ;
  final columnId = 'node_id';
  final _columnTitle = 'name';
  final _columnDescription = 'txt';



  Map<String, dynamic> toMap(Note object) {
    return <String, dynamic>{
      _columnTitle: object.title,
      _columnDescription: object.description
    };
  }

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



class DAO<T> {
  DatabaseProvider databaseProvider;

  DAO(this.databaseProvider);


  T fromMap(Map<String, dynamic> query) {
    T note;
    note.id = query[columnId];
    note.title = query[_columnTitle];
    note.description = query[_columnDescription];
    return note;
  }


  Future<List<T>> getItems() async {
    final db = await databaseProvider.db();
    T o;
    List<Map> maps = await db.rawQuery(T.getQuery());
    return T.mapper(maps);
  }
}



*/