import 'dart:convert';

import 'data/servers.dart';
import 'page_add_user.dart';
import 'page_one_user.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';

class PageListUsers extends StatelessWidget {
  final String listName;
  final Server choosenServer;

  const PageListUsers({
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
        onPressed: () => _navigateToUserAddPage(context),
        child: const Icon(Icons.add),
        // backgroundColor: Colors.green,
      ),

      // FutureBuilder<Response>(
      //   future: Provider.of<ApiService>(context).getPosts(),
      //   // future: Provider.of<ApiService>(context).getPost(postId),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //     final List posts = json.decode(snapshot.data!.bodyString);

      //       // final Map post = json.decode(snapshot.data!.bodyString);
      //       return _buildPost(posts);
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }

  // Padding _buildPost(Map post) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           post['title'],
  //           style: TextStyle(
  //             fontSize: 30,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Text(post['body']),
  //       ],
  //     ),
  //   );
  // }
  // In real apps, use some sort of state management (BLoC is cool)
  // to prevent duplicate requests when the UI rebuilds

  // Snapshot's data is the Response
  // You can see there's no type safety here (only List<dynamic>)
  // print(snapshot.data!.bodyString);
  // if (snapshot.data.bodyString != null)
  // Show a loading indicator while waiting for the posts

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).usersAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List posts = json.decode(snapshot.data!.bodyString);
          return _buildPosts(context, posts);
        } else {
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
              posts[index]['surName'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index]['firstName']),
            onTap: () => _navigateToOneUserPage(context, posts[index]['id']),
          ),
        );
      },
    );
  }

  void _navigateToOneUserPage(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageOneUser(
          choosenServer: choosenServer,
          user_id: id.toString(),
        ),
      ),
    );
  }

  _navigateToUserAddPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageAddUser(
          choosenServer: choosenServer,
        ),
        // builder: (context) => PageRequests(selectedItem),
        // builder: (context) => SinglePostPage(postId: int(id)),
      ),
    );
  }
}
