import 'data/api_service.dart';
import 'data/servers.dart';
import 'package:apiconsument/page_add_offices.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_home.dart';
import 'page_list_cars.dart';

class PageDeleteCar extends StatelessWidget {
  final String plateNumber;
  final Server choosenServer;

  const PageDeleteCar(
      {Key? key, required this.plateNumber, required this.choosenServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car removed: ' + plateNumber),
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
      future:
          Provider.of<ApiService>(context).deleteCarByPlateNumber(plateNumber),
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
              builder: (context) => PageListCars(
                choosenServer: choosenServer,
                listName: 'Cars',
              ),
            ),
          ),
          child: Text("Go to car list"),
        ),
        Text(myRespond),
        ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PageMenu(
                choosenServer: choosenServer,
              ),
            ),
          ),
          child: Text("Go to main menu"),
        ),
      ],
    );
  }
}

void _navigateToAddOffice(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PageAddOffices(),
    ),
  );
}
