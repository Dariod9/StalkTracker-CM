import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/collegeinfo.dart';
import 'package:hackathon/drawers/loginmaindrawer.dart';

class afterloginapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Center(
                child: Text(
              "Stalk Tracker",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 29,
              ),
            )),
            duration: 3000,
            splashTransition: SplashTransition.decoratedBoxTransition,
            backgroundColor: Colors.grey.shade900,
            nextScreen: afterloginmainpage()),
      ),
    );
  }
}

class afterloginmainpage extends StatefulWidget {
  @override
  State<afterloginmainpage> createState() => _loginpageState();
}

class _loginpageState extends State<afterloginmainpage> {
  final Stream<QuerySnapshot> _collegesList =
      FirebaseFirestore.instance.collection('College_List').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'IIIT info',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: loginmaindrawer(context),
        body: Userinfo());
  }
}

class Userinfo extends StatefulWidget {
  @override
  _UserinfoState createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  String emailid = FirebaseAuth.instance.currentUser?.email ?? '';
  final Stream<QuerySnapshot> _collegesstream =
      FirebaseFirestore.instance.collection('College_List').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _collegesstream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                ),
                onTap: () {
                  var documentid = document.id;
                  var collegename = data['Name'];
                  var collegeestablished = data['Established'];
                  var collegeplacement = data['Avg_CTC'];
                  var collegerank = data['NIRF Ranking'];
                  collegeinfo(documentid, collegeplacement, collegeestablished,
                      collegerank, collegename, emailid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => collegeinfopage(),
                      ));
                },
                title: Text(
                  data['Name'],
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          );
        });
  }
}
