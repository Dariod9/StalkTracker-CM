import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class contactuspage extends StatelessWidget {

  void mailLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  void _openURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
  
  Widget _showQrCode(BuildContext context) {
    return new AlertDialog(
      title: Text("Scan for a surprise"),
      content: new Container(
        child: QrImage(data: "https://www.youtube.com/watch?v=fcZXfoB2f70"),
        width: 200,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
          'Contact Us',
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
                'Contact Us',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15.0),),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/dario.png"),
                radius: 50,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _showQrCode(context),
                );
              },
              title: Text("Dário Matos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                ),
              ),
              subtitle: Text("Influencer",
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
              trailing: Wrap(
                spacing: -15,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _openURL('https://www.instagram.com/dariod99/');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.mail_outline_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      mailLaunch('mailto:dario.matos@ua.pt');
                    },
                  ),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.only(bottom: 10.0),),

            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/pedro.jpeg"),
                radius: 50,
              ),
              title: Text("Pedro Almeida",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              subtitle: Text("Developer",
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              trailing:
                Wrap(
                  spacing: -15,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _openURL('https://www.instagram.com/pedr0aalmeida/');
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        mailLaunch('mailto:pedro22@ua.pt');
                      },
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    ));
  }
}
