import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/profile.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'bluetooth_controller.dart';
import 'classes/contact.dart';




class friendspage extends StatefulWidget {
  @override
  State<friendspage> createState() => _friendspage2();
}

class _friendspage2 extends State<friendspage> {

  final contactcontroller = TextEditingController();
  List<Contact> closes=[];

  @override
  void initState() {
    scan();
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
              'Friends List',
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
                    'List of Friends',
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
                    String nome=contactcontroller.text;
                    var box = await Hive.openBox('testBox');

                    try {
                      var result = await box.get(nome);
                      Contact c= result;
                      c.close=true;
                      await box.put(c.address, c);

                      result = await box.get(nome);
                      c=result;
                      print(c.close);
                    }
                    catch(e){
                      print("NÃO EXISTE ENDEREÇO");
                    }

                    try {
                      for(int i=0; i<box.length;i++){
                        Contact temp=await box.getAt(i);
                        if(temp.name==nome){
                          temp.close=true;
                          await box.put(temp.address, temp);
                          break;
                          }
                        }
                    }
                    catch(e){
                      print("NÃO EXISTE NOME");
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

  Future<void> setCloseFriends() async {
    String nome=contactcontroller.text;
    var box = await Hive.openBox('testBox');

    try {
      var result = await box.get(nome);
      Contact c= result;
      c.close=true;
      await box.put(c.address, c);
    }
    catch(e){
      print("NÃO EXISTE ENDEREÇO");
    }

    try {
      for(int i=0; i<box.length;i++){
        Contact temp=await box.getAt(i);
        if(temp.name==nome){
          temp.close=true;
          await box.put(temp.address, temp);
          break;
        }
      }
    }
    catch(e){
      print("NÃO EXISTE NOME");
    }

  }
  Widget listaDinamica(){
    return  new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: closes.length,
        itemBuilder: (BuildContext ctxt, int index){
          for(int i=0;i<closes.length;i++) print(closes[index].name+"\n");
          if(closes.length==0) return new Text("No devices!");
          else return _drawTile(closes[index]);
        }
    );
  }

  Widget _drawTile(Contact c){
    String name="";
    if(c.name.contains(":")) name="(no name)";
    else name=c.name;

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
    closes= await BluetoothController.getClose();
    print("CLOSES: ");
    print(closes[0].toString());
    setState(() {

    });
  }

}
