import 'package:apiconsument/page_list_requestspendings.dart';
// import 'package:flutter_restart/flutter_restart.dart';
import 'package:restart_app/restart_app.dart';

import 'data/servers.dart';
import 'page_list_cars.dart';
import 'page_list_offices.dart';
import 'page_list_requests.dart';
import 'page_list_users.dart';
import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       // The initialized PostApiService is now available down the widget tree
//       create: (_) => ApiService.create(),
//       // builder: (_) => ApiService.create(),
//       // Always call dispose on the ChopperClient to release resources
//       dispose: (context, ApiService service) => service.client.dispose(),
//       child: MaterialApp(
//         // theme: ThemeData.from(
//         //   // colorScheme: choosenServer,
//         //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
//         //   // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
//         // ),
//         title: 'Material App',
//         // home: PageHome(),
//         home: PageMenu(server: server,
//             //   onThemeChanged: (data) {
//             //   setState(() {
//             //     brightness = data.brightness;
//             //   });
//             // },
//             ),
//         // home: HomePage(),
//       ),
//     );
//   }
// }

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

  // const
  PageMenu({Key? key, required this.choosenServer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: choosenServer.colorSchemeBackground,
      // theme: ThemeData.from(
      //     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      //   ),
      appBar: AppBar(
        title: Text(choosenServer.type + ' ' + choosenServer.city),
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

  // FutureBuilder<Response> _buildBody(BuildContext context) {
  //   // FutureBuilder is perfect for easily building UI when awaiting a Future
  //   // Response is the type currently returned by all the methods of PostApiService
  //   return FutureBuilder<Response>(
  //     // In real apps, use some sort of state management (BLoC is cool)
  //     // to prevent duplicate requests when the UI rebuilds
  //     // future: Provider.of<ApiService>(context).getPosts(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return _buildPosts(context, menu);
  //       } else {
  //         // Show a loading indicator while waiting for the posts
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

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
          builder: (context) => PageListRequestsCars(
            choosenServer: choosenServer,
            listName: menu[0],
          ),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
    else if (selectedItem == menu[1]) // Users!!!!!!!!!!!!!!!!!!!!
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListUsers(
            listName: selectedItem,
            choosenServer: choosenServer,
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
    else if (selectedItem == "RequestsPendings") // Offices
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListRequestsPendingsCars(
            choosenServer: choosenServer,
            listName: selectedItem,
          ),
          // builder: (context) => SinglePostPage(postId: int(id)),
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
    // _restartApp(); // Cars

// }
    // runApp(MaterialAppHome(choosenServer));
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => PageSelectServer(),
    //   ),
    // );
    else
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageListRequestsCars(
            choosenServer: choosenServer,
            listName: 'requests',
          ),
          // builder: (context) => SinglePostPage(postId: int(id)),
        ),
      );
  }

  // void _restartApp() async {
  //   FlutterRestart.restartApp();
  // }
}

// class PageRequests extends StatelessWidget {
//   // PageRequests(String selectedItem);

//   @override
//   Widget build(BuildContext context) {
//     return Text("Hi!");
//     // throw UnimplementedError();
//   }
// }
