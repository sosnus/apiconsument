import 'data/servers.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'page_list_cars.dart';
import 'page_list_offices.dart';
import 'page_list_requests.dart';
import 'page_list_requestspendings.dart';
import 'page_list_users.dart';

class PageMenu extends StatelessWidget {
  final Server choosenServer;

  final List<String> menu = <String>[
    "Requests",
    "Users",
    "Offices",
    "Cars",
    "RequestsPendings",
    "Logout"
  ];

  PageMenu({Key? key, required this.choosenServer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(choosenServer.type + ' ' + choosenServer.city),
      ),
      body: _buildPosts(context, menu),
    );
  }

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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
          builder: (context) => PageListRequestsCars(
            choosenServer: choosenServer,
            listName: menu[0],
          ),
        ),
      );
    else if (selectedItem == menu[1]) // Users!!!!!!!!!!!!!!!!!!!!
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListUsers(
            listName: selectedItem,
            choosenServer: choosenServer,
          ),
        ),
      );
    else if (selectedItem == menu[2]) // Offices
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListOffices(
            listName: selectedItem,
          ),
        ),
      );
    else if (selectedItem == "RequestsPendings") // Offices
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListRequestsPendingsCars(
            choosenServer: choosenServer,
            listName: selectedItem,
          ),
        ),
      );
    else if (selectedItem == menu[3]) // Cars
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListCars(
            choosenServer: choosenServer,
            listName: selectedItem,
          ),
        ),
      );
    else if (selectedItem == "Logout")
      Restart.restartApp();
    else
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListRequestsCars(
            choosenServer: choosenServer,
            listName: 'requests',
          ),
        ),
      );
  }
}
