import 'package:flutter/material.dart';

class Role {
  var id;
  var title;
  var description;
  var previleges;

  Role(id, title, description, previleges) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.previleges = previleges;
  }

  Role.fromObject() {}
}
