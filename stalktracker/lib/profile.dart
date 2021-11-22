import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'bluetooth_controller.dart';
import 'classes/contact.dart';




class profile extends StatefulWidget {
  late Contact c;
  profile(this.c);
  @override
  State<profile> createState() => _profile2(this.c);
}

class _profile2 extends State<profile> {
  late Contact c;

  _profile2(this.c);

  final contactcontroller = TextEditingController();
  List<Contact> closes = [];

  // @override
  // void initState() {
  //   // scan();
  // }

  void mailLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(c.address,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.all(3),
              child: ListView(
                children: [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white,),
                  title: new Text(c.name, style: TextStyle(color: Colors.white),),
                ),
                  ListTile(
                    leading: Icon(Icons.bluetooth, color: Colors.white,),
                    title: new Text(c.address, style: TextStyle(color: Colors.white),),
                  ),
                  ListTile(
                    leading: Icon(Icons.bluetooth, color: Colors.white,),
                    title: new Text(c.proximity.toString(), style: TextStyle(color: Colors.white),),
                  ),
            ]
              )
          ),
        ));
  }
}