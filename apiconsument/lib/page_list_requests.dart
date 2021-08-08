import 'dart:convert';
import 'data/api_service.dart';
import 'data/requestCar.dart';
import 'data/servers.dart';
import 'package:apiconsument/page_one_requestCar.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageListRequestsCars extends StatelessWidget {
  final Server choosenServer;
  final bool isPendings;

  const PageListRequestsCars({
    Key? key,
    required this.isPendings,
    required this.choosenServer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List: Requests Cars' + (isPendings ? ' Pendings' : ' ')),
      ),
      body: _buildList(context),
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
}
