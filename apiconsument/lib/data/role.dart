import 'package:flutter/material.dart';

class Role {
  final int id;
  final String title;
  final String description;
  final String previleges;

  Role(this.id, this.title, this.description, this.previleges);

  Future<Widget> showAsWidget() async {
    return Container(
      child: Column(
        children: [
          Text(id.toString()),
          Text(title.toString()),
          Text(description.toString())
        ],
      ),
    );
  }

  String asString() {
    return '[' + id.toString() + '] ' + title;
  }
}
