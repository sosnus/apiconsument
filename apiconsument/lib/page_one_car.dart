import 'dart:convert';

import 'package:apiconsument/page_add_offices.dart';
import 'package:apiconsument/single_post_page.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
import 'data/car.dart';

class PageOneCar extends StatelessWidget {
  final String plate_number;

  const PageOneCar({Key? key, required this.plate_number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About car: ' + plate_number),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () => _navigateToAddOffice(context),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<ApiService>(context).carByPlateNumber(plate_number),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          // print(snapshot.data!.bodyString);
          // if (snapshot.data.bodyString != null)
          final Car myCar =
              Car.fromJson(json.decode(snapshot.data!.bodyString));
          // final List posts = json.decode(snapshot.data!.bodyString);
          return _buildPosts(context, myCar);
        } else {
          // Show a loading indicator while waiting for the posts
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
    // return ListView(children: myCar.convertToWidgetList());
    // Card(
    //   elevation: 4,
    //   child: ListTile(
    //     title: Text(
    //       myCar.licenseNumber,
    //       style: TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //     // subtitle: Text(posts[index]['body']),
    //   ),
    // ),
    // ]
    // );
    // return Column(child: ScrollView(c));
    // return ListView.builder(
    //   itemCount: posts.length,
    //   padding: EdgeInsets.all(8),
    //   itemBuilder: (context, index) {
    // return Text(myCar.toString());
    // return Card(
    //   elevation: 4,
    //   child: ListTile(
    //     title: Text(
    //       posts[index]['plateNumber'],
    //       style: TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //     subtitle: Text(posts[index]['model'] +
    //         "; " +
    //         posts[index]['type'] +
    //         "; " +
    //         posts[index]['vinNumber']),
    //     onTap: () => _navigateToPost(context, posts[index]['plateNumber']),
    //   ),
    // );
  }
  // );
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
