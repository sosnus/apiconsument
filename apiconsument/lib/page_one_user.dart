import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/api_service.dart';
import 'data/user.dart';
import 'page_delete_user.dart';

class PageOneUser extends StatelessWidget {
  final String user_id;

  const PageOneUser({Key? key, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About user: ' + user_id),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        // onPressed: () => _navigateToAddOffice(context),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Are You sure to delete user?'),
            content: Text('User id: ' + user_id),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PageDeleteUser(
                      user_id: user_id,
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
      future: Provider.of<ApiService>(context).userById(int.parse(user_id)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          // print(snapshot.data!.bodyString);
          // if (snapshot.data.bodyString != null)
          final User myUser =
              User.fromJson(json.decode(snapshot.data!.bodyString));
          // final List posts = json.decode(snapshot.data!.bodyString);
          return _buildPosts(context, myUser);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, User myUser) {
    print(myUser.toString());
    return myUser.convertToWidgetList();
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
