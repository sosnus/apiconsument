import 'dart:convert';
import 'data/api_service.dart';
import 'data/car.dart';
import 'data/servers.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_delete_car.dart';

class PageOneCar extends StatelessWidget {
  final Server choosenServer;
  final String plateNumber;

  const PageOneCar(
      {Key? key, required this.plateNumber, required this.choosenServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About car: ' + plateNumber),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Are You sure to delete car?'),
            content: Text('Plate number: ' + plateNumber),
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
                      plateNumber: plateNumber,
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
      future: Provider.of<ApiService>(context).carByPlateNumber(plateNumber),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final Car myCar =
              Car.fromJson(json.decode(snapshot.data!.bodyString));
          return _buildPosts(context, myCar);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, Car myCar) {
    print(myCar.toString());
    return myCar.convertToWidgetList();
  }
}
