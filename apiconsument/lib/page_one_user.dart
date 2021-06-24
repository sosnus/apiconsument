import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/api_service.dart';
import 'data/office.dart';
import 'data/servers.dart';
import 'data/user.dart';
import 'page_delete_user.dart';

class PageOneUser extends StatelessWidget {
  final String user_id;

  final Server choosenServer;

  const PageOneUser(
      {Key? key, required this.choosenServer, required this.user_id})
      : super(key: key);

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
            // content: _buildList2(context),

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
                      choosenServer: choosenServer,
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

  //   FutureBuilder<Response> _buildList2(BuildContext context) {
  //   return FutureBuilder<Response>(
  //     future: Provider.of<ApiService>(context).usersAll(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final List posts = json.decode(snapshot.data!.bodyString);
  //         return _buildPosts(context, posts);
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).userById(int.parse(user_id)),
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

// TO DELETE, just test
  FutureBuilder<Response> _buildList2(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).officeAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List posts = json.decode(snapshot.data!.bodyString);
          final List<Office> offices = [];
          for (var item in posts) {
            offices.add(Office(item['id'], item['city'], item['type']));
          }
          // return _buildPosts(context, posts);
          return _buildOfficeList(context, offices);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildOfficeList(BuildContext context, List<Office> offices) {
    return ListView.builder(
      itemCount: offices.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // return Office.obj(offices[index]).toWidgetCard();
        return Card(
          elevation: 4,
          child: ListTile(
            leading: offices[index].type == "HQ"
                ? Icon(Icons.home_work)
                : Icon(Icons.home_filled),
            title: Text(
              offices[index].id.toString() +
                  '. ' +
                  offices[index].city.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(offices[index].type),
            onTap: () => Navigator.pop(context, 'Cancel'),
            // onTap: () => _navigateToPost(context, offices[index].id),
          ),
        );
      },
    );
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
