import 'package:apiconsument/page_add_request.dart';

import 'data/servers.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'page_list_cars.dart';
import 'page_list_offices.dart';
import 'page_list_requests.dart';
import 'page_list_users.dart';

enum MenuAction {
  Requests,
  RequestsPendings,
  AddRequest,
  Users,
  Offices,
  Cars,
  Logout,
}

// final List<String> menu = <String>[
//   "Requests",
//   "Users",
//   "Offices",
//   "Cars",
//   "RequestsPendings",
//   "Logout"
// ];
// final List<String> menuBO = <String>[
//   "Requests",
//   "Users",
//   "Offices",
//   "Cars",
//   "RequestsPendings",
//   "Logout"
// ];

// final List<String> menuHQ = <String>[
//   "Requests",
//   "RequestsPendings",
//   "Users",
//   "Offices",
//   "Cars",
//   "Logout"
// ];

class PageMenu extends StatelessWidget {
  final Server choosenServer;

  final List<MenuAction> menuHQ = <MenuAction>[
    MenuAction.Requests,
    MenuAction.RequestsPendings,
    MenuAction.Cars,
    MenuAction.Offices,
    MenuAction.Users,
    MenuAction.Logout
  ];
  final List<MenuAction> menuBO = <MenuAction>[
    MenuAction.Requests,
    MenuAction.AddRequest,
    MenuAction.Cars,
    MenuAction.Users,
    MenuAction.Logout
  ];

  PageMenu({Key? key, required this.choosenServer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(choosenServer.type + ' ' + choosenServer.city),
      ),
      body: _buildPosts(context, choosenServer.type == "HQ" ? menuHQ : menuBO),
    );
  }

  ListView _buildPosts(BuildContext context, List menuType) {
    return ListView.builder(
      itemCount: menuType.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // if (index == menuType.length - 1) return Spacer();
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              menuType[index].toString().replaceAll("MenuAction.", ""),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _navigateToPage(context, menuType[index]),
            // onTap: () => _navigateToPost(context, menu[index]),
          ),
        );
      },
    );
  }

  void _navigateToPage(BuildContext context, MenuAction selectedItem) {
    print(choosenServer.toString());

    switch (selectedItem) {
      case MenuAction.Requests:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageListRequestsCars(
              choosenServer: choosenServer,
              isPendings: false,
            ),
          ),
        );
        break;
      case MenuAction.RequestsPendings:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageListRequestsCars(
              choosenServer: choosenServer,
              isPendings: true,
            ),
          ),
        );
        break;
      case MenuAction.Users:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageListUsers(
              choosenServer: choosenServer,
            ),
          ),
        );
        break;
      case MenuAction.Offices:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageListOffices(
                // choosenServer: choosenServer,
                ),
          ),
        );
        break;
      case MenuAction.AddRequest:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageAddRequest(
              choosenServer: choosenServer,
            ),
          ),
        );
        break;
      case MenuAction.Cars:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageListCars(
              choosenServer: choosenServer,
            ),
          ),
        );
        break;
      case MenuAction.Logout:
        Restart.restartApp();
        break;
    }
    // else if (selectedItem == menu[1])
  }

//   void _navigateToPost(BuildContext context, String selectedItem) {
//     if (selectedItem == menu[0])
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageListRequestsCars(
//             choosenServer: choosenServer,
//             listName: menu[0],
//           ),
//         ),
//       );
//     else if (selectedItem == menu[1]) // Users!!!!!!!!!!!!!!!!!!!!
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageListUsers(
//             listName: selectedItem,
//             choosenServer: choosenServer,
//           ),
//         ),
//       );
//     else if (selectedItem == menu[2]) // Offices
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageListOffices(
//             listName: selectedItem,
//           ),
//         ),
//       );
//     else if (selectedItem == "RequestsPendings") // Offices
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageListRequestsPendingsCars(
//             choosenServer: choosenServer,
//             listName: selectedItem,
//           ),
//         ),
//       );
//     else if (selectedItem == menu[3]) // Cars
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageListCars(
//             choosenServer: choosenServer,
//             listName: selectedItem,
//           ),
//         ),
//       );
//     else if (selectedItem == "Logout")
//       Restart.restartApp();
//     else
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PageListRequestsCars(
//             choosenServer: choosenServer,
//             listName: 'requests',
//           ),
//         ),
//       );
//   }

}
