import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
import 'data/servers.dart';
import 'data/user.dart';
import 'page_home.dart';
import 'page_list_users.dart';
import 'page_add_offices.dart';

class PageAfterAddUser extends StatelessWidget {
  final User user;
  final Server choosenServer;

  const PageAfterAddUser(
      {Key? key, required this.user, required this.choosenServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User added: ' + user.id.toString()),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.backpack_outlined),
        onPressed: () => _navigateToAddOffice(context),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).postNewUser(user.toJson()),

      // future: Provider.of<ApiService>(context).deleteUserById(user_id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String myRespond = snapshot.data!.bodyString;
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
    return Column(
      children: [
        Text(myRespond),
        ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PageListUsers(
                choosenServer: choosenServer,
                listName: 'Users',
              ),
            ),
          ),
          child: Text("Go to user list"),
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

void _navigateToAddOffice(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PageAddOffices(),
    ),
  );
}
