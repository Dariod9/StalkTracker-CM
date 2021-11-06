import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon/collegeinfo.dart';
import 'package:hackathon/drawers/logindrawer.dart';
import 'package:hackathon/login_controller.dart';

class afterlogingmailapp extends StatelessWidget {
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
            nextScreen: afterlogingmail()),
      ),
    );
  }
}

final controller = Get.put(LoginController());

class afterlogingmail extends StatefulWidget {
  @override
  State<afterlogingmail> createState() {
    controller.authentication();
    return _loginpageState();
  }
}

class _loginpageState extends State<afterlogingmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Stalk Tracker',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Obx(() {
          return logindrawer(context);
        }),
        body: googleuserinfo());
  }
}

class googleuserinfo extends StatefulWidget {
  @override
  _UserinfoState createState() => _UserinfoState();
}

class _UserinfoState extends State<googleuserinfo> {
  final Stream<QuerySnapshot> _collegesstream =
      FirebaseFirestore.instance.collection('College_List').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _collegesstream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
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
                  collegeinfo(
                      documentid,
                      collegeplacement,
                      collegeestablished,
                      collegerank,
                      collegename,
                      controller.googleAccount.value?.email);
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
