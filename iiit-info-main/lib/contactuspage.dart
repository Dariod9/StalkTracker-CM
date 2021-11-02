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
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Icon(
            //         Icons.mail_outline_outlined,
            //         color: Colors.white,
            //       ),
            //     ),
            //     TextButton(
            //         onPressed: () {
            //           mailLaunch('mailto:dario.matos@ua.pt?');
            //         },
            //         child: Text(
            //           'dario.matos@ua.pt',
            //           style: TextStyle(fontSize: 20),
            //         )),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Icon(
            //         Icons.mail_outline_outlined,
            //         color: Colors.white,
            //       ),
            //     ),
            //     TextButton(
            //         onPressed: () {
            //           mailLaunch('mailto:pedro22@ua.pt?');
            //         },
            //         child: Text(
            //           'pedro22@ua.pt',
            //           style: TextStyle(fontSize: 20),
            //         ))
            //   ],
            // ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Icon(
            //         Icons.phone,
            //         color: Colors.white,
            //       ),
            //     ),
            //     TextButton(
            //         onPressed: () {
            //           mailLaunch('tel:+917989772884');
            //         },
            //         child: Text(
            //           '+91 79897 72884',
            //           style: TextStyle(fontSize: 20),
            //         )),
            //   ],
            // ),
          ],
        ),
      ),
    ));
  }
}
