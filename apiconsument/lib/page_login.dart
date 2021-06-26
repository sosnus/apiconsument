// import 'package:apiconsument/page_menu.dart';
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
        child: const Icon(Icons.login),
        onPressed: () => runApp(MaterialAppHome(choosenServer)),
        // onPressed: () => Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PageMenu(
        //       choosenServer: choosenServer,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget loginWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        // padding: EdgeInsets.all(25.0),
        children: [
          // Text("Login here"),
          Text(
            choosenServer.address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          loginForm(),
          // ElevatedButton(
          //     onPressed: () {
          //       runApp(MaterialAppHome(choosenServer));
          //     },
          //     child: Text("🚪 Login"))
        ]);
  }

  Widget loginForm() {
    return Container(
      margin: const EdgeInsets.all(30.0),
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
