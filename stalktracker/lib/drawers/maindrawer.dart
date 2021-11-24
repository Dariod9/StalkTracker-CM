import 'package:flutter/material.dart';
import 'package:hackathon/aboutuspage.dart';
import 'package:hackathon/contactuspage.dart';
import 'package:hackathon/friendspage.dart';
import 'package:hackathon/historypage.dart';
import 'package:hackathon/main.dart';

import '../blacklist.dart';

Drawer maindrawer(BuildContext context) {
  return Drawer(
      child: Container(
    color: Colors.black87,
    child: ListView(
      children: <Widget>[
        Container(
            height: 90.0,
            child: DrawerHeader(
              child: Text('Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  )),
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.only(left: 10),
            )),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => loginpage(),
                ));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
          ),
          title: Text(
            'About us',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => aboutuspage()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.mark_as_unread_outlined,
            color: Colors.white,
          ),
          title: Text(
            'Contact us',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => contactuspage()));
          },
        ),
        Padding(padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)-550)),
        Container(
          child: SizedBox(height: 120, width: 80, child:Image(image: AssetImage("assets/logo.png") ))
        )
      ],
    ),
  ));
}
