import 'dart:convert';
import 'data/api_service.dart';
import 'data/servers.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_add_offices.dart';
import 'page_one_car.dart';

class PageListCars extends StatelessWidget {
  final String listName;
  final Server choosenServer;

  const PageListCars({
    Key? key,
    required this.listName,
    required this.choosenServer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List: ' + listName),
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
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<ApiService>(context).carAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          final List posts = json.decode(snapshot.data!.bodyString);
          return _buildPosts(context, posts);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index]['plateNumber'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index]['model'] +
                "; " +
                posts[index]['type'] +
                "; " +
                posts[index]['vinNumber']),
            onTap: () => _navigateToPost(context, posts[index]['plateNumber']),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageOneCar(
          plateNumber: id,
          choosenServer: choosenServer,
        ),
      ),
    );
  }

  void _navigateToAddOffice(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageAddOffices(),
      ),
    );
  }
}
