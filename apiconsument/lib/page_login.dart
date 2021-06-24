import 'package:apiconsument/page_home.dart';
import 'package:flutter/material.dart';
import 'data/servers.dart';
import 'material_app_home.dart';
// import 'data/api_service.dart';

class PageLogin extends StatelessWidget {
  final Server choosenServer;

  const PageLogin({Key? key, required this.choosenServer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login ' + choosenServer.type + ' ' + choosenServer.city),
      ),
      body: loginWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageMenu(
              choosenServer: choosenServer,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginWidget() {
    return Column(children: [
      Text("Login here"),
      Text(choosenServer.address),
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
          child: Text("Do not push it"))
    ]);
  }
}
