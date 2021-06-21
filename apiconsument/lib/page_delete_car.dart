import 'dart:convert';

import 'package:apiconsument/page_add_offices.dart';
import 'package:apiconsument/single_post_page.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
import 'data/car.dart';
import 'page_home.dart';
import 'page_list_cars.dart';

class PageDeleteCar extends StatelessWidget {
  final String plate_number;

  const PageDeleteCar({Key? key, required this.plate_number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car removed: ' + plate_number),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.backpack_outlined),
        onPressed: () => _navigateToAddOffice(context),
        // onPressed: () => _navigateToAddOffice(context),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      // future: Provider.of<ApiService>(context).carAll(),

      future:
          Provider.of<ApiService>(context).deleteCarByPlateNumber(plate_number),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          // print(snapshot.data!.bodyString);
          // if (snapshot.data.bodyString != null)
          final String myRespond = snapshot.data!.bodyString;
          // Car.fromJson(json.decode(snapshot.data!.bodyString));
          // final List posts = json.decode(snapshot.data!.bodyString);
          return _buildPosts(context, myRespond);
        } else {
          // Show a loading indicator while waiting for the posts
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
              builder: (context) => PageHome(
                  // listName: 'Cars',
                  ),
            ),
          ),
          child: Text("Go to main menu"),
        ),
      ],
    );

    // print(myCar.toString());
    // return myCar.convertToWidgetList();
  }
}

void _navigateToPost(BuildContext context, int id) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => SinglePostPage(postId: id),
    ),
  );
}

void _navigateToAddOffice(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PageAddOffices(),
    ),
  );
}
// }
