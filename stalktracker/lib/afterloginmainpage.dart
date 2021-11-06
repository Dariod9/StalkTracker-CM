import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/collegeinfo.dart';
import 'package:hackathon/drawers/loginmaindrawer.dart';

import 'bluetooth_controller.dart';
import 'classes/contact.dart';
import 'package:loading_animations/loading_animations.dart';


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

  List<Contact> contacts= <Contact>[];
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
        drawer: loginmaindrawer(context),
        // body: Userinfo());
    body: Center(
      // padding: const EdgeInsets.all(8),
          child:
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 600,
                child:
                  Column(
                      children: [
                        CircleAvatar(
                          //backgroundImage:
                          radius: 50,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text(FirebaseAuth.instance.currentUser?.email ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                        Padding(padding: EdgeInsets.only(top: 45)),
                        Text("Recent Finds", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 300,
                          child: listaDinamica()
                          ),
                // LoadingRotating.square(
                //   borderColor: Colors.white70,
                //   borderSize:0,
                //   size: 30.0,
                //   backgroundColor: Colors.white,
                //   duration: Duration(milliseconds: 2000),
                // ),
                        FloatingActionButton.extended(
                          onPressed:() async {
                              contacts=BluetoothController.getDevices();
                              await Future.delayed(const Duration(seconds: 3), (){});

                              print("ESPEREI");
                              setState(() {
                              });;
                            },
                          label:  Text("Recent Finds", style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ]

                  ))
    ],
    ),
    )
    );
  }

  Widget listaDinamica(){
    return  new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: contacts.length,
        itemBuilder: (BuildContext ctxt, int index){
          print("LISTA:"+contacts.length.toString());
          if(contacts.length==0) return new Text("No devices!");
          else return _drawTile(contacts[index]);
        }
    );
  }

  Widget _drawTile(Contact c){
    return ListTile(
      leading: Icon(Icons.bluetooth, color: Colors.white,),
      title: new Text(c.name, style: TextStyle(color: Colors.white),),
      trailing: c.distanceIcon(c)
    );
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
