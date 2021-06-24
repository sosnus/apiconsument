import 'dart:convert';
import 'package:apiconsument/page_home.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/servers.dart';
import 'material_app_home.dart';
import 'page_delete_car.dart';
import 'data/api_service.dart';
import 'data/car.dart';

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

  // FutureBuilder<Response> _buildList(BuildContext context) {
  //   return FutureBuilder<Response>(
  //     // In real apps, use some sort of state management (BLoC is cool)
  //     // to prevent duplicate requests when the UI rebuilds
  //     future: Provider.of<ApiService>(context).carByPlateNumber(plate_number),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         // Snapshot's data is the Response
  //         // You can see there's no type safety here (only List<dynamic>)
  //         // print(snapshot.data!.bodyString);
  //         // if (snapshot.data.bodyString != null)
  //         final Car myCar =
  //             Car.fromJson(json.decode(snapshot.data!.bodyString));
  //         // final List posts = json.decode(snapshot.data!.bodyString);
  //         return _buildPosts(context, myCar);
  //       } else {
  //         // Show a loading indicator while waiting for the posts
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  // Widget _buildPosts(BuildContext context, Car myCar) {
  //   print(myCar.toString());
  //   return myCar.convertToWidgetList();
  // }
}

// void _navigateToPost(BuildContext context, int id) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => SinglePostPage(postId: id),
//     ),
//   );
// }

// void _navigateToAddOffice(BuildContext context) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => PageAddOffices(),
//     ),
//   );
// }
