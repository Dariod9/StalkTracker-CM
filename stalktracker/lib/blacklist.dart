import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/profile.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'bluetooth_controller.dart';
import 'classes/contact.dart';




class blacklist extends StatefulWidget {
  @override
  State<blacklist> createState() => _blacklist2();
}

class _blacklist2 extends State<blacklist> {

  final contactcontroller = TextEditingController();
  List<Contact> danger=[];

  @override
  void initState() {
    scan();
    BluetoothController.clearClose();
  }

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
            title: Text(
              'Blacklist',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(3),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'List of Danger Contacts',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                SizedBox(
                    height: 300,
                    child: listaDinamica()
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Icon(
                //         Icons.person,
                //         color: Colors.white,
                //       ),
                //     ),
                //     TextButton(
                //         onPressed: () {
                //           // mailLaunch('mailto:Groupztrio@gmail.com?');
                //         },
                //         child: Text(
                //           'Pedro Fajardo',
                //           style: TextStyle(fontSize: 20),
                //         ))
                //   ],
                // ),

                Padding(
                  padding: const EdgeInsets.only(left:16, right: 16),
                  child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: contactcontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.white, ),
                    hintText: 'Device Name ou Address',
                  ),
                )
                ),
                Padding(padding: const EdgeInsets.only(top: 20, left:50, right: 50),
                  child:FloatingActionButton.extended(
                  heroTag: "2",
                  onPressed: () async {
                    String endereco=contactcontroller.text;
                    var box = await Hive.openBox('testBox');

                    try {
                      var result = await box.get(endereco);
                      Contact c= result;
                      c.black=true;
                      await box.put(c.address, c);
                      print("Address");
                      print(c.black);
                    }
                    catch(e){
                      print("NÃO EXISTE ENDEREÇO");
                    }

                    scan();
                    setState(() {

                    });
                  }
                  ,
                  label: Text('Add Friend'),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                )),
              ],
            ),
          ),
        ));
  }

  Widget listaDinamica(){
    return  new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: danger.length,
        itemBuilder: (BuildContext ctxt, int index){
          for(int i=0;i<danger.length;i++) print(danger[index].name+"\n");
          if(danger.length==0) return new Text("No devices!");
          else return _drawTile(danger[index]);
        }
    );
  }

  Widget _drawTile(Contact c){
    String name=c.name;

    return ElevatedButton(
      onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder:(context)=>profile(c))); },
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
      child: ListTile(
        leading: Icon(Icons.bluetooth, color: Colors.white,),
        title: new Text(name, style: TextStyle(color: Colors.white),),
        trailing: Wrap(
          spacing: -15,
          children: <Widget>[
            Icon(Icons.signal_cellular_4_bar, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Future<void> scan() async {
    danger= await BluetoothController.getBlack();
    print("DANGER: ");
    // print(danger[0].toString());
    setState(() {

    });
  }

}
