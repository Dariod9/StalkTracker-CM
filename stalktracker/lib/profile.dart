import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  File? image;

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
          body: Column(
              // padding: EdgeInsets.all(3),
              children: [
                    Expanded(
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
              )),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  color: Colors.white,
                  onPressed: () => pickImage(),
                )
              ),
                Expanded(

                child: teste()),
                  // ListView.builder(
                // itemCount: 2,
                // itemBuilder: (BuildContext ctx, int index) {
                // return Image.file(File(c.path1));}))
              // image!=null ? Image.file(image!, width: 160, height: 160, fit: BoxFit.cover,): FlutterLogo(size: 160),
                Spacer(),
              ]


          ),
        ));
  }

  Future pickImage() async {
     try {
       final image = await ImagePicker().pickImage(source: ImageSource.camera);
       if (image == null) return;

       final imagTemp = File(image.path);
       print(image.path);

       if(c.path1=="") c.path1=image.path;
       else if(c.path2=="") c.path2=image.path;
       else if(c.path3=="") c.path3=image.path;

       //
       // Directory appDir = await getApplicationDocumentsDirectory();
       // final fileName = path.basename(imageFile.path);
       // final savedImage = await imagTemp.copy(newPath) .copy('${appDir.path}/$fileName');

       setState(() {
         this.image = imagTemp;
       });
     }
     on PlatformException catch(e){
       print(e);
     }
  }

  teste() {
    if (c.path3 != "") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [
                Image.file(File(c.path1)),
                Image.file(File(c.path2)),
                Image.file(File(c.path3)),
              ]
          ));
    }

    else if (c.path2 != "") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [
                Image.file(File(c.path1)),
                Image.file(File(c.path2)),
              ]
          ));
    }

    else if (c.path1 != "") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [
                Image.file(File(c.path1)),
              ]
          ));
    }

    else
      return Text("There are no current pictures with " + c.address);
  }
}