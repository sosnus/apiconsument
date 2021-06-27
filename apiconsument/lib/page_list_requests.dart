import 'dart:convert';
import 'data/api_service.dart';
import 'data/requestCar.dart';
import 'data/servers.dart';
import 'package:apiconsument/page_one_requestCar.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageListRequestsCars extends StatelessWidget {
  // final String listName;
  final Server choosenServer;

  final bool isPendings;

  const PageListRequestsCars({
    Key? key,
    // required this.listName,
    required this.isPendings,
    required this.choosenServer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('List: Requests Cars' + (isPendings ? ' Pendings' : ' ')),
        // title: Text('List: Requests Cars'),
        // title: Text('List: ' + listName),
      ),
      body: _buildList(context),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.car_rental),
      //       label: 'Accept',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.cancel),
      //       label: 'Reject',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   // selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped(_selectedIndex),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: isPendings
          ? Provider.of<ApiService>(context).requestsPendingsAll()
          : Provider.of<ApiService>(context).requestsAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List requestsCarsCollection =
              json.decode(snapshot.data!.bodyString);
          final List<RequestCar> requestCar = [];
          for (var item in requestsCarsCollection) {
            requestCar.add(RequestCar.fromJson(item));
          }
          if (requestCar.length == 0) {
            if (isPendings) {
              return ListView(
                children: [
                  Center(
                    child: Text(
                      "No pendings requests!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            } else {
              return ListView(
                children: [
                  Center(
                    child: Text(
                      "No requests!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }
          }
          return _buildRequestCarList(context, requestCar);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildRequestCarList(BuildContext context, List<RequestCar> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return InkWell(
          child: posts[index].showAsCard(),
          onTap: () =>
              _navigateToRequestDetails(context, posts[index].requestId),
        );
      },
    );
  }

  _navigateToRequestDetails(BuildContext context, int requestId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageOneRequesCar(
          choosenServer: choosenServer,
          requestId: requestId,
          isPending: isPendings,
        ),
      ),
    );
  }

  // _onItemTapped(int value) {
  //   print(value);
  // }
}
