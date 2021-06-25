import 'package:apiconsument/page_home.dart';
import 'package:flutter/material.dart';
import 'data/servers.dart';
import 'material_app_home.dart';
// import 'data/api_service.dart';

class PageLogin extends StatefulWidget {
  final Server choosenServer;

  // const
  PageLogin({Key? key, required this.choosenServer}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState(choosenServer);
}

class _PageLoginState extends State<PageLogin> {
  final Server choosenServer;

  _PageLoginState(this.choosenServer);

  TextEditingController formLoginController = TextEditingController();

  TextEditingController formPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // myController.dispose();
    super.dispose();
  }

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
      loginForm(),
      // TextButton(onPressed: onPressed, child: child)

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

  Widget loginForm() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Login',
            ),
            controller: formLoginController,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            controller: formPasswordController,
          ),
        ],
      ),
    );
  }
}
