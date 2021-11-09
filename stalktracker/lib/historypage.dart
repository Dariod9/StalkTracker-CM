import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';


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
  final _connectionsHistory = ["a", "b", "c", "d", "a", "b", "c", "d", "b", "c", "d", "a", "b", "c", "d"];

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
        itemCount: _connectionsHistory.length,
        itemBuilder: (context, index) {
          return _buildRow(_connectionsHistory[index]);
        }
    );
  }

  Widget _buildRow(String s){
    return ListTile(
      title: new Text(s, style: TextStyle(color: Colors.white),),
    );
  }

  @override
  void initState() {
    _authentication();
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
