import 'package:apiconsument/page_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'data/api_service.dart';
// import 'home_page.dart';

import 'package:logging/logging.dart';

import 'data/servers.dart';
import 'material_app_home.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      // The initialized PostApiService is now available down the widget tree
      create: (_) => ApiService.create(),
      // builder: (_) => ApiService.create(),
      // Always call dispose on the ChopperClient to release resources
      dispose: (context, ApiService service) => service.client.dispose(),
      child: MaterialApp(
        // theme: ThemeData.from(
        //   // colorScheme: choosenServer,
        //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        //   // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        // ),
        title: 'Material App',
        // home: PageHome(),
        home: PageSelectServer(),
        //   onThemeChanged: (data) {
        //   setState(() {
        //     brightness = data.brightness;
        //   });
        // },
        // home: HomePage(),
      ),
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

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

/// This is the stateful widget that the main application instantiates.
class PageSelectServer extends StatefulWidget {
  const PageSelectServer({Key? key}) : super(key: key);

  @override
  State<PageSelectServer> createState() => _MyPageSelectServerState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyPageSelectServerState extends State<PageSelectServer> {
  int _count = 0;
  Server choosenServer = Servers.serversList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IAP Car App'),
      ),
      body: Center(child: widgetSelectServer()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  // List<Server> buildServersList() => Servers.serversList;

  void myOnPressed(Server? value) {
    // (Server Value) {
    setState(() {
      choosenServer = value!;
    });
  }

  widgetSelectServer() {
    return Column(
      children: [
        Text('Choose server'),
        Text('You have pressed the button $_count times.'),
        DropdownButton<Server>(
          hint: Text("Select item"),
          value: choosenServer,
          onChanged: myOnPressed,
          // },
          items: Servers.serversList.map((Server s) {
            return DropdownMenuItem<Server>(
              value: s,
              child: Row(
                children: <Widget>[
                  Icon(s.icon),
                  // s.icon,
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
          }).toList(),
        ),
        ElevatedButton(
            // MaterialApp(
            onPressed: () {
              runApp(MaterialAppHome(choosenServer));
              // Navigator.push(
              //   context,
              //   // MaterialPageRoute(
              //   //     builder: (context) => PageHome(
              //   //           server: choosenServer,
              //   //         )),
              //   MaterialPageRoute(
              //       builder: (context) => MaterialAppHome(
              //             server: choosenServer,
              //           )),
              // );
            },
            child: Text("Login"))
      ],
    );
  }
}
