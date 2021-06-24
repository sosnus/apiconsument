import 'dart:convert';
import 'package:apiconsument/data/requestCar.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/servers.dart';
import 'page_delete_car.dart';
import 'data/api_service.dart';
import 'data/car.dart';

class PageOneRequesCar extends StatelessWidget {
  final int requestId;
  final Server choosenServer;

  const PageOneRequesCar(
      {Key? key, required this.requestId, required this.choosenServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text('About request #' + requestId.toString()),
      ),
      body: _buildList(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        // currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        // onPressed: () => _navigateToAddOffice(context),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Are You sure to delete car?'),
            content: Text('Plate number: ' + requestId.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PageDeleteCar(
                      choosenServer: choosenServer,
                      plate_number: requestId.toString(),
                    ),
                  ),
                ),
                child: const Text('Yes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<ApiService>(context).requestById(requestId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          // print(snapshot.data!.bodyString);
          // if (snapshot.data.bodyString != null)
          final RequestCar myRequestCar =
              RequestCar.fromJson(json.decode(snapshot.data!.bodyString));
          // final List posts = json.decode(snapshot.data!.bodyString);
          return _buildPosts(context, myRequestCar);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, RequestCar myRequestCar) {
    print(myRequestCar.toString());
    return myRequestCar.convertToWidgetList();
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
