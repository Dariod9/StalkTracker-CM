import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

  part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact {
  Contact({required this.name, required this.proximity, required this.address, required this.date, required this.close, required this.black, required this.path1, required this.path2, required this.path3});

  @HiveField(0)
  String name;

  @HiveField(1)
  int proximity;

  @HiveField(2)
  String address;

  @HiveField(3)
  DateTime? date;

  @HiveField(4)
  bool close;

  @HiveField(5)
  bool black;

  @HiveField(6)
  String path1;

  @HiveField(7)
  String path2;

  @HiveField(8)
  String path3;
  // @HiveField(4)
  // List<Figuras> asdasd

  // constructor
  // Contact(String name, int proximity, String address) {
  //   this.name = name;
  //   this.address=address;
  //   this.proximity = proximity;
  int getDistance(){
    if(proximity<-60 || proximity>-91) return 2;
    else if(proximity<-90) return 3;
    else return 1;
  }

  Widget distanceIcon(Contact c){
    switch(getDistance()){
      case 1: return Icon(Icons.signal_cellular_4_bar, color: Colors.green);
      case 2: return Icon(Icons.signal_cellular_4_bar, color: Colors.orangeAccent);
      case 3: return Icon(Icons.signal_cellular_4_bar, color: Colors.red);
      default:     return Icon(Icons.dangerous, color: Colors.white);
    }
  }

  String toString(){
    return "Name: "+this.name+" Address: "+this.address+" Close: "+this.close.toString()+" Black: "+this.black.toString();
  }


//   Future<void> something() async {
// //     Directory appDocDirectory = await getApplicationDocumentsDirectory();
// //
// //     new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true)
// // // The created directory is returned as a Future.
// //         .then((Directory directory) {
// //       print('Path of New Dir: '+directory.path);
// //     });
//
//     // var path = appDocDirectory.path;
//     // Hive
//     //   ..init(path)
//     //   ..registerAdapter(ContactAdapter());
//
//     var box = await Hive.openBox('testBox');
//
//     var contact = Contact(
//       name: 'BT_TESTE',
//       proximity: -50,
//       address: "yau",
//     );
//
//     await box.put('teste', contact);
//
//     print("A?? VAI TESTE:"+box.get('teste').toString()); // Dave: 22
//     print(box.length);
//     await Hive.close();
//
//   }
}