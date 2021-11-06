import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon/aboutuspage.dart';
import 'package:hackathon/contactuspage.dart';
import 'package:hackathon/googleloginmain.dart';
import 'package:hackathon/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

final controller = Get.put(LoginController());
Drawer logindrawer(BuildContext context) {
  return Drawer(
      child: Container(
    color: Colors.black87,
    child: ListView(
      children: <Widget>[
        Container(
          height: 220,
          child: DrawerHeader(
              child: Column(
            children: [
              CircleAvatar(
                backgroundImage: Image.network(
                        controller.googleAccount.value?.photoUrl ?? '')
                    .image,
                radius: 50,
              ),
              SizedBox(
                height: 8,
              ),
              Text(controller.googleAccount.value?.displayName ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              SizedBox(
                height: 8,
              ),
              Text(controller.googleAccount.value?.email ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(
                height: 16,
              ),
            ],
          )),
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
                  builder: (context) => afterlogingmail(),
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
            Icons.logout,
            color: Colors.white,
          ),
          title: Text(
            'logout',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () async {
            controller.logout(context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('gmail');
          },
        ),
      ],
    ),
  ));
}
