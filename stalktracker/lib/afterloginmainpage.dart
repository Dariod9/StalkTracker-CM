
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/collegeinfo.dart';
import 'package:hackathon/drawers/loginmaindrawer.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  final ImagePicker _picker = ImagePicker();
  XFile? image=null;
  final Stream<QuerySnapshot> _collegesList =
      FirebaseFirestore.instance.collection('College_List').snapshots();

  List<Contact> contactsNow= <Contact>[];
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
                        ElevatedButton(
                          onPressed: () async {
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(2),
                            primary: Colors.blue, // <-- Button color
                            onPrimary: Colors.white70, // <-- Splash color
                          ),
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
                          heroTag: "primeiro heroi",
                          onPressed:() async {
                            bool? connectionResult = await FlutterBluetoothSerial.instance.isEnabled;
                            if(connectionResult!=null && connectionResult==true){
                              scan();
                            }
                            else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>  AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text("Open Bluetooth Settings?"),
                                // content:
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Open'),
                                    onPressed: AppSettings.openBluetoothSettings,

                                  ),
                                  TextButton(
                                    child: const Text('Close'),
                                    onPressed:() { Navigator.of(context).pop();},

                                  ),
                                ],
                              ));
                            }
                            },
                          label:  Text("Search", style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
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
          for(int i=0;i<contacts.length;i++) print(contacts[index].name+"\n");
          if(contacts.length==0) return new Text("No devices!");
          else return _drawTile(contacts[index]);
        }
    );
  }

  Widget _drawTile(Contact c){
    if(c.black){
      return ElevatedButton(
      onLongPress: (){
        showDialog(
          context: context,
          builder: (BuildContext context) =>  AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Add to Friends List?"),
            // content:
            actions: <Widget>[
              TextButton(
                child: const Text('Add'),
                onPressed: () async {
                  var box = await Hive.openBox('testBox');
                  Contact copy= await box.get(c.address);
                  print("Copia");
                  print(copy);
                  await box.delete(c.address);
                  copy.close=true;
                  await box.put(copy.address,copy);

                  Navigator.of(context).pop();
                },

              ),
              TextButton(
                child: const Text('Close'),
                onPressed:() { Navigator.of(context).pop();},

              ),
            ],
          ));},
      onPressed: () {  },
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
      child: ListTile(
        leading: Icon(Icons.bluetooth, color: Colors.white,),
        title: new Text(c.name, style: TextStyle(color: Colors.white),),
        trailing: Wrap(
          spacing: 10,
          children: <Widget>[
            Icon(Icons.warning_amber_outlined, color: Colors.red),
            Icon(Icons.signal_cellular_4_bar, color: Colors.green)
          ],
        ),
      ),
    );}
    else{
    return ElevatedButton(
    onLongPress: (){
    showDialog(
    context: context,
    builder: (BuildContext context) =>  AlertDialog(
    backgroundColor: Colors.white,
    title: Text("Add to Friends List?"),
    // content:
    actions: <Widget>[
    TextButton(
    child: const Text('Add'),
    onPressed: () async {
    var box = await Hive.openBox('testBox');
    Contact copy= await box.get(c.address);
    print("Copia");
    print(copy);
    await box.delete(c.address);
    copy.close=true;
    await box.put(copy.address,copy);

    Navigator.of(context).pop();
    },
    ),
    TextButton(
      child: const Text('Close'),
      onPressed:() { Navigator.of(context).pop();},),],
        ));},
      onPressed: () {  },
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
      child: ListTile(
        leading: Icon(Icons.bluetooth, color: Colors.white,),
        title: new Text(c.name, style: TextStyle(color: Colors.white),),
        trailing: Wrap(
          spacing: -15,
          children: <Widget>[
          Icon(Icons.signal_cellular_4_bar, color: Colors.green),
            ],
            ),
            ),
          );}
  }
  Future<void> scan() async {

    var box = await Hive.openBox('testBox');

    contacts=<Contact>[];
    // print("LISTA1:"+contacts.length.toString());
    contacts= await BluetoothController.getDevices2();

    // contactsNow=contacts;
    Fluttertoast.showToast(
        msg: 'Please wait',
        gravity: ToastGravity.BOTTOM,
        fontSize: 18,
        backgroundColor: Colors.white,
        textColor: Colors.black);
    await Future.delayed(const Duration(seconds: 8), (){});
    print("Contactos:");
    print(contacts);
    await verifyBlacklist();

    contacts.forEach((element) async {await verifyAndAdd(element);});
    // print("A limpar");
    await cleanContacts();
    // print(contacts);
    // print(await box.getLength().toString());
    // Contact a = box.get(contacts[0].address);

    // box.close();
    print("Ai vai state");
    setState(() {
    });;
  }

  Future<void> verifyAndAdd(Contact c) async {
    if(await BluetoothController.existsInBox(c.address)==false){
      addContact(c);
    }
  }

  Future<void> addContact(Contact c) async {
    print("A ADICIONAR O "+c.address);
    var box = await Hive.openBox('testBox');
    while(box.containsKey(c.address)){
      box.delete(c.address);
    }
    // print(box.length);
    await box.put(c.address, c);

    await Hive.close();

  }

  Future<void> cleanContacts() async {
    var finalCont=<Contact>[];
    var box = await Hive.openBox('testBox');

    contacts.forEach((element) async {
      if(await BluetoothController.existsInBox(element.address)==true){
        Contact c=await box.get(element.address);
        if(c.close==false) {
          print("Não era close o " + c.name);
          print("Keys:"+box.keys.length.toString());
          print("Length:"+box.length.toString());
          finalCont.add(c);
        }
          print(box.length);
      }
    });



    contacts=finalCont;
  }

  Future<void> verifyBlacklist() async {
    var box = await Hive.openBox('testBox');
    for(Contact c in box.values){
      if(c.black) {
        print("Tá black");
        for (Contact c2 in contacts){
          print("Comparando "+c.address+" com "+c2.address);
          if (c2.address == c.address || c2.name == c.name)
            {
              return showDialog(
                context: context,
                builder: (BuildContext context) =>  AlertDialog(
                  backgroundColor: Colors.red,
                  title: Text("!Danger nearby!"+c2.address),
                  // content:
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed:() { Navigator.of(context).pop();},

                    ),
                  ],
                ));
            }}
      }
    }
  }



//   Future<void> start() async {
//       Directory appDocDirectory = await getApplicationDocumentsDirectory();
//
//       new Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true)
// // The created directory is returned as a Future.
//           .then((Directory directory) {
//         print('Path of New Dir: ' + directory.path);
//       });
//
//       var path = appDocDirectory.path;
//       Hive
//         ..init(path)
//         ..registerAdapter(ContactAdapter());
//   }
}

// class Userinfo extends StatefulWidget {
//   @override
//   _UserinfoState createState() => _UserinfoState();
// }
//
// class _UserinfoState extends State<Userinfo> {
//   String emailid = FirebaseAuth.instance.currentUser?.email ?? '';
//   final Stream<QuerySnapshot> _collegesstream =
//       FirebaseFirestore.instance.collection('College_List').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: _collegesstream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data()! as Map<String, dynamic>;
//               return ListTile(
//                 leading: Icon(
//                   Icons.book_outlined,
//                   color: Colors.white,
//                 ),
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right_outlined,
//                   color: Colors.white,
//                 ),
//                 onTap: () {
//                   var documentid = document.id;
//                   var collegename = data['Name'];
//                   var collegeestablished = data['Established'];
//                   var collegeplacement = data['Avg_CTC'];
//                   var collegerank = data['NIRF Ranking'];
//                   collegeinfo(documentid, collegeplacement, collegeestablished,
//                       collegerank, collegename, emailid);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => collegeinfopage(),
//                       ));
//                 },
//                 title: Text(
//                   data['Name'],
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             }).toList(),
//           );
//         });
//   }
//}

