import 'dart:convert';
import 'data/api_service.dart';
import 'data/office.dart';
import 'package:apiconsument/page_add_offices.dart';
import 'package:apiconsument/a_single_post_page.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageListOffices extends StatelessWidget {
  final String listName;

  const PageListOffices({
    Key? key,
    required this.listName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List: ' + listName),
      ),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddOffice(context),
      ),
    );
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).officeAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List posts = json.decode(snapshot.data!.bodyString);
          final List<Office> offices = [];
          for (var item in posts) {
            offices.add(Office(item['id'], item['city'], item['type']));
          }
          return _buildOfficeList(context, offices);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildOfficeList(BuildContext context, List<Office> offices) {
    return ListView.builder(
      itemCount: offices.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            leading: offices[index].type == "HQ"
                ? Icon(Icons.home_work)
                : Icon(Icons.home_filled),
            title: Text(
              offices[index].id.toString() +
                  '. ' +
                  offices[index].city.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(offices[index].type),
            onTap: () => _navigateToPost(context, offices[index].id),
          ),
        );
      },
    );
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
}
