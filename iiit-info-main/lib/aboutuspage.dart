import 'package:flutter/material.dart';

class aboutuspage extends StatelessWidget {
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
          'About us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(3),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width/2)-10, top: 30),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 30),
              child: Column(
                  children: [
                    Text(
                      'Project Name : Stalk Tracker',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                     ),
                    Padding(padding: EdgeInsets.only(top:20)),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                  children: [
                  Text(
                    'Group members : ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                    Padding(padding: EdgeInsets.only(top:15)),
                    Column(
                    children: [
                      Text(
                        'Dário Matos (89288)',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Pedro Almeida (89205)',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  )
                ],
              )),
                  ]
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
