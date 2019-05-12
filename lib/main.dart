import 'package:flutter/material.dart';
import 'DAO.dart';


class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build (BuildContext context) {

    final List<Entry> data = List<Entry>();

    var db = DatabaseProvider.get;



    var repo = NotesDatabaseRepository(db);
    repo.getNotes().then((notes) {
      print("reading...");
      for( final item in notes ) {
        print(item.title);
        data.add(Entry(item));
      }
    }, onError: (e) {
      print(e);
    });


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

// The entire multilevel list displayed by this app.
/*
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
*/

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
        children: [Text("agasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsdagasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsd" )],
      );


//      return Card(child: Text(root.title + "agasgfasdfasdfasd asdfasd fas asdf asdfasdf as fs fasdfasdf as fasfadsf asdf assdfasdf asdf asdfasd fsd" ));
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
//  var res =  PermissionsHelper.requestPermission(permission);
//  print("permission request result is " + res.toString());
  runApp(ExpansionTileSample());
}



/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_permissions_helper/permissions_helper.dart';

void main() => runApp( MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() =>  _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Permission permission;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Permission Helper Test App'),
          ),
          body: Center(
            child: IntrinsicWidth(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 224, 224),
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 197, 197, 197),
                              offset: Offset(0.0, 2.0),
                              blurRadius: 1.0,
                              spreadRadius: -1.0,
                            ),
                          ]
                      ),
                      child: DropdownButton(
                          items: _getDropDownItems(),
                          value: permission,
                          onChanged: onDropDownChanged
                      ),
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      child: Text("Check permission"),
                      onPressed: checkPermission,
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      child: Text("Request permission"),
                      onPressed: requestPermission,
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      child: Text("Get permission status"),
                      onPressed: getPermissionStatus,
                    ),
                    SizedBox(height: 8.0),
                    RaisedButton(
                      child: Text("Open settings"),
                      onPressed: PermissionsHelper.openSettings,
                    ),
                  ]
              ),
            ),
          )
      ),
    );
  }

  onDropDownChanged(Permission permission) {
    setState(() => this.permission = permission);
    print(permission);
  }

  requestPermission() async {
    var res = await PermissionsHelper.requestPermission(permission);
    print("permission request result is " + res.toString());
  }

  checkPermission() async {
    bool res = await PermissionsHelper.hasPermission(permission);
    print("permission is " + res.toString());
  }

  getPermissionStatus() async {
    final res = await PermissionsHelper.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }

  List<DropdownMenuItem<Permission>>_getDropDownItems() {
    List<DropdownMenuItem<Permission>> items =  List();
    Permission.values.forEach((permission) {
      var item  =  DropdownMenuItem(child:  Text(permissionToString(permission)), value: permission);
      items.add(item);
    });
    return items;
  }
}

*/
