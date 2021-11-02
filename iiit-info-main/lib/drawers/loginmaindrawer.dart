import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon/aboutuspage.dart';
import 'package:hackathon/afterloginmainpage.dart';
import 'package:hackathon/changepassword.dart';
import 'package:hackathon/contactuspage.dart';
import 'package:hackathon/login_controller.dart';
import 'package:hackathon/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final controller = Get.put(LoginController());
Drawer loginmaindrawer(BuildContext context) {
  return Drawer(
      child: Container(
    color: Colors.black87,
    child: ListView(
      children: <Widget>[
        Container(
          height: 200,
          child: DrawerHeader(
              child: Column(
            children: [
              CircleAvatar(
                //backgroundImage:
                radius: 50,
              ),
              SizedBox(
                height: 16,
              ),
              Text(FirebaseAuth.instance.currentUser?.email ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          )),
        ),
        SizedBox(
          height: 8,
        ),
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
                  builder: (context) => afterloginmainpage(),
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
        ListTile(
          leading: Icon(
            Icons.vpn_key_sharp,
            color: Colors.white,
          ),
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => changepassword()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: Text(
            'logout',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('Email');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => loginpage(),
                  ));
            });
            Navigator.pop(context);
          },
        ),
      ],
    ),
  ));
}
