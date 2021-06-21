import 'dart:convert';

import 'package:apiconsument/page_list.dart';
import 'package:apiconsument/page_list_cars.dart';
import 'package:apiconsument/page_list_offices.dart';
import 'package:apiconsument/page_list_users.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
// import 'single_post_page.dart';

class PageHome extends StatelessWidget {
  final List<String> menu = <String>["Requests", "Users", "Offices", "Cars"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api client'),
      ),
      // body: _buildBody(context),
      body: _buildPosts(context, menu),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     // The JSONPlaceholder API always responds with whatever was passed in the POST request
      //     final response =
      //         await Provider.of<ApiService>(context).postPost({'key': 'value'});
      //     // We cannot really add any new posts using the placeholder API,
      //     // so just print the response to the console
      //     print(response.body);
      //   },
      // ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      // future: Provider.of<ApiService>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildPosts(context, menu);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // menu.add("Requests");

  ListView _buildPosts(BuildContext context, List menu) {
    return ListView.builder(
      itemCount: menu.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              menu[index],
              // posts[index]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(posts[index]['body']),
            onTap: () => _navigateToPost(context, menu[index]),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, String selectedItem) {
    if (selectedItem == menu[0])
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageList(
            listName: selectedItem,
          ),
          // builder: (context) => PageRequests(selectedItem),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
    else if (selectedItem == menu[1]) // Users!!!!!!!!!!!!!!!!!!!!
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListUsers(
            listName: selectedItem,
          ),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
    else if (selectedItem == menu[2]) // Offices
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListOffices(
            listName: selectedItem,
          ),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
    else if (selectedItem == menu[3]) // Cars
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListCars(
            listName: selectedItem,
          ),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
    else
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageRequests(),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
  }
}

class PageRequests extends StatelessWidget {
  // PageRequests(String selectedItem);

  @override
  Widget build(BuildContext context) {
    return Text("Hi!");
    // throw UnimplementedError();
  }
}
