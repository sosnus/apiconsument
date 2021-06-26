import 'dart:convert';
import 'data/api_service.dart';
import 'data/servers.dart';
import 'package:apiconsument/data/requestCar.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_delete_car.dart';

class PageOneRequesCar extends StatelessWidget {
  final int requestId;
  final Server choosenServer;
  final bool isPending;

  const PageOneRequesCar(
      // Server choosenServer,
      {Key? key,
      required this.requestId,
      required this.choosenServer,
      required this.isPending})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About request #' + requestId.toString()),
      ),
      body: _buildList(context),
      bottomNavigationBar: isPending
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Are You sure to delete car?'),
            content: Text('Plate number: ' + requestId.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PageDeleteCar(
                      choosenServer: choosenServer,
                      plateNumber: requestId.toString(),
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
      future: Provider.of<ApiService>(context).requestById(requestId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final RequestCar myRequestCar =
              RequestCar.fromJson(json.decode(snapshot.data!.bodyString));
          return _buildPosts(context, myRequestCar);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, RequestCar myRequestCar) {
    print(myRequestCar.toString());
    return myRequestCar.convertToWidgetList();
  }
}
