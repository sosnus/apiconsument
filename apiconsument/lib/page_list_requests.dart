import 'dart:convert';

import 'package:apiconsument/page_add_offices.dart';
import 'package:apiconsument/page_one_requestCar.dart';
import 'package:apiconsument/single_post_page.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
// import 'data/api_serviceHQ.dart';
import 'data/office.dart';
import 'data/requestCar.dart';
import 'data/servers.dart';

class PageListRequestsCars extends StatelessWidget {
  final String listName;
  final Server choosenServer;

  const PageListRequestsCars({
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
        onPressed: () {},
        child: const Icon(Icons.add),
        // onPressed: () => _navigateToAddOffice(context),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).requestsAll(),
      //     : Provider.of<ApiServiceBO>(context).requestsAll(),
      // future: choosenServer.type == "HQ"
      //     ? Provider.of<ApiServiceHQ>(context).requestsAll()
      //     : Provider.of<ApiServiceBO>(context).requestsAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List requestsCarsCollection =
              json.decode(snapshot.data!.bodyString);
          final List<RequestCar> requestCar = [];
          for (var item in requestsCarsCollection) {
            requestCar.add(RequestCar.fromJson(item));
            // offices.add(Office(item['id'], item['city'], item['type']));
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
          //  Card(
          //   elevation: 4,
          //   child: ListTile(
          //     title: Text(
          //       posts[index]['title'],
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     subtitle: Text(posts[index]['body']),
          //   ),
          // ),
          onTap: () =>
              _navigateToRequestDetails(context, posts[index].requestId),
        );
      },
    );
  }

  // ListView _buildRequestCarList(
  //     BuildContext context, List<RequestCar> requestCar) {
  //   return ListView.builder(
  //     itemCount: requestCar.length,
  //     padding: EdgeInsets.all(8),
  //     itemBuilder: (context, index) {
  //       // return Office.obj(offices[index]).toWidgetCard();
  //       return Card(
  //         elevation: 4,
  //         child: ListTile(
  //           // leading: offices[index].type == "HQ"
  //           //     ? Icon(Icons.home_work)
  //           //     : Icon(Icons.home_filled),
  //           title: Text(
  //             requestCar[index].getSomeInfo,
  //             // offices[index].id.toString() +
  //             //     '. ' +
  //             //     offices[index].city.toString(),
  //             // style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           // subtitle: Text(offices[index].type),
  //           onTap: () => _navigateToPost(context, 1),
  //           // onTap: () => _navigateToPost(context, offices[index].id),
  //         ),
  //       );
  //     },
  //   );
  // }

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
  //       builder: (context) => PageAddOffices(), // TODO:
  //     ),
  //   );
  // }

  _navigateToRequestDetails(BuildContext context, int requestId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageOneRequesCar(
            choosenServer: choosenServer, requestId: requestId), // TODO:
      ),
    );
  }
}
