import 'package:flutter/material.dart';

class Role {
  final int id;
  final String title;
  final String description;
  final String previleges;

  Role(this.id, this.title, this.description, this.previleges) {
    // this.id = id;
    // this.title = title;
    // this.description = description;
    // this.previleges = previleges;
  }

  Future<Widget> showAsWidget() async {
    return Container(
      child: Column(
        children: [
          Text(id.toString()),
          Text(title.toString()),
          Text(description.toString())
          // ,Text(id.toString())
        ],
      ),
    );
  }

  String asString() {
    return '[' + id.toString() + '] ' + title;
  }

  // Role.fromObject() {}
}
