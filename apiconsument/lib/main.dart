import 'data/servers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'page_login.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PageSelectServer(),
    );
  }
}

void _setupLogging() {
  // Logger.root.level = Level.ALL;
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

/// This is the stateful widget that the main application instantiates.
class PageSelectServer extends StatefulWidget {
  const PageSelectServer({Key? key}) : super(key: key);

  @override
  State<PageSelectServer> createState() => _MyPageSelectServerState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyPageSelectServerState extends State<PageSelectServer> {
  Server choosenServer = Servers.serversList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IAP Car App'),
      ),
      body: Center(child: widgetSelectServer()),
    );
  }

  void myOnPressed(Server? value) {
    setState(() {
      choosenServer = value!;
    });
  }

  widgetSelectServer() {
    return Column(
      children: [
        Text('Choose server'),
        DropdownButton<Server>(
          hint: Text("Select item"),
          value: choosenServer,
          onChanged: myOnPressed,
          items: Servers.serversList.map(
            (Server s) {
              return DropdownMenuItem<Server>(
                value: s,
                child: Row(
                  children: <Widget>[
                    Icon(s.icon),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      s.city,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageLogin(
                  choosenServer: choosenServer,
                ),
              ),
            );
          },
          child: Text("Choose"),
        ),
      ],
    );
  }
}
