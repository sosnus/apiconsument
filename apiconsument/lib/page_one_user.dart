import 'dart:convert';
import 'data/api_service.dart';
import 'data/servers.dart';
import 'data/user.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_delete_user.dart';

class PageOneUser extends StatelessWidget {
  final String userId;

  final Server choosenServer;

  const PageOneUser(
      {Key? key, required this.choosenServer, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About user: ' + userId),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Are You sure to delete user?'),
            content: Text('User id: ' + userId),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PageDeleteUser(
                      choosenServer: choosenServer,
                      userId: userId,
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
      future: Provider.of<ApiService>(context).userById(int.parse(userId)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final User myUser =
              User.fromJson(json.decode(snapshot.data!.bodyString));
          return _buildPosts(context, myUser);
        } else {
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
