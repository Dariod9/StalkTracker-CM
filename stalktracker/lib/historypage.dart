import 'dart:core';

import 'package:hackathon/profile.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

import 'classes/contact.dart';


class fromDateWidget extends StatelessWidget {
  final String text;

  fromDateWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Text("Stalkers from: " + text,
      style: TextStyle(color: Colors.white, fontSize: 22),);
  }
}

class historypage extends StatefulWidget {

  @override
  State<historypage> createState() => _historypageState();
}

class _historypageState extends State<historypage> {

  DateTime _selectedDate = DateTime.now();
  var connectionsHistory = [];

  // biometrics
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometrics = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = false;

    try{
      canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch(e){
      print(e);
    }

    if (!mounted) return;

    print(canCheckBiometrics);

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });

  }

  Future<void> _authenticateNow() async {
    bool isAuthenticated = false;

    try{
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: "Authenticate to see history.",

      );
    } on PlatformException catch(e){
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthenticated) {
        print("Authentication succeeded");
      }
      else {
        Navigator.pop(context);
      }
    });

  }

  Future<void> _authentication() async {
    _checkBiometrics();
    await Future.delayed(const Duration(milliseconds: 1), (){});
    if (_canCheckBiometrics){
      _authenticateNow();
    }
  }


  void getConnections(DateTime date) async {
    var box = await Hive.openBox('testBox');

    connectionsHistory=[];

    List userList = await box.values.toList();
    // var toRemove = [];

    // userList.forEach((element) {if(element.date != date) toRemove.add(element);});
    List cont=userList.cast<Contact>();
    // cont.forEach((element) {print(element.date);});
    cont.removeWhere((element) => element.date.day != date.day);
    connectionsHistory=cont;

    print(connectionsHistory);

    setState((){});
    await Hive.close();
  }

  void mailLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate){
      getConnections(picked);
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildConnectionsHistory(){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: connectionsHistory.length,
        itemBuilder: (context, index) {
          return _buildRow(connectionsHistory[index]);
        }
    );
  }

  Widget _buildRow(Contact c){
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

  @override
  void initState() {
    _authentication();
    getConnections(DateTime.now());
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
              'History',
              style: TextStyle(color: Colors.white),
            ),
            // actions: <Widget>[
            //   IconButton(
            //       icon: Icon(Icons.fingerprint),
            //       onPressed: _authentication,
            //   )
            // ],
          ),
          body: Padding(
            padding: EdgeInsets.all(3),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: fromDateWidget("${_selectedDate.toString()}".split(" ")[0]),
                  trailing: IconButton(
                      icon: Icon(Icons.date_range, color: Colors.white,),
                      onPressed: () => _selectDate(context)),
                ),
                // Expanded(child: ListView(children: [_buildConnectionsHistory()],)),
                Row(
                  children: [
                    new Expanded(child: _buildConnectionsHistory()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

}
