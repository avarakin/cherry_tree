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
