import 'dart:convert';
import 'package:apiconsument/page_list_requests.dart';
import 'data/api_service.dart';
import 'data/servers.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_add_offices.dart';
import 'page_menu.dart';

class PageAfterAssignRequest extends StatelessWidget {
  final int requestId;
  final Server choosenServer;

  const PageAfterAssignRequest(
    this.requestId,
    this.choosenServer, {
    Key? key,
    // required this.listName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign: Done'),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddOffice(context),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).assignRequestCar(requestId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String message = snapshot.data!.bodyString;
          // final String message = json.decode(snapshot.data!.bodyString);
          return _buildPage(context, message);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // ListView _buildOfficeList(BuildContext context, String message) {
  //   // return ListView.builder(
  //   //   itemCount: offices.length,
  //   //   padding: EdgeInsets.all(8),
  //   //   itemBuilder: (context, index) {
  //       return Card(
  //         elevation: 4,
  //         child: ListTile(
  //           leading: offices[index].type == "HQ"
  //               ? Icon(Icons.home_work)
  //               : Icon(Icons.home_filled),
  //           title: Text(
  //             offices[index].id.toString() +
  //                 '. ' +
  //                 offices[index].city.toString(),
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           subtitle: Text(offices[index].type),
  //           // onTap: () => _navigateToPost(context, offices[index].id),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildPage(BuildContext context, String myRespond) {
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
              child: Text("Go to requests car list"),
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

  // void _navigateToPost(BuildContext context, int id) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => SinglePostPage(postId: id),
  //     ),
  //   );
  // }

  void _navigateToAddOffice(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageAddOffices(),
      ),
    );
  }
}
