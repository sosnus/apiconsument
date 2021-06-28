import 'data/api_service.dart';
import 'data/requestCar.dart';
import 'data/servers.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_list_requests.dart';
import 'page_menu.dart';

class PageAfterAddRequest extends StatelessWidget {
  final RequestCar requestCar;
  final Server choosenServer;

  const PageAfterAddRequest(
      {Key? key, required this.requestCar, required this.choosenServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request added: ' + requestCar.carModel.toString()),
      ),
      body: _buildList(context),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.backpack_outlined),
      //   onPressed: () => _navigateToAddOffice(context),
      // ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context)
          .postNewRequestCar(requestCar.toJsonOnly4field()),

      // future: Provider.of<ApiService>(context).deleteUserById(user_id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String myRespond = "wait...";
          if (snapshot.data!.statusCode == 200)
            myRespond = "Request sent!";
          else
            myRespond = "Request sent!";
          // final String myRespond = snapshot.data!.bodyString;
          return _buildPosts(context, myRespond);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, String myRespond) {
    return Container(
        margin: const EdgeInsets.all(30.0),
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(myRespond),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PageListRequestsCars(
                    choosenServer: choosenServer, isPendings: true,
                    // listName: 'Users',
                  ),
                ),
              ),
              child: Text("Go to requests list"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PageMenu(
                    choosenServer: choosenServer,
                    // server: Servers.serversList.first,
                  ),
                ),
              ),
              child: Text("Go to main menu"),
            ),
          ],
        ));
  }
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
