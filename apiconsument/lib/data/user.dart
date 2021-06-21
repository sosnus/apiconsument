import 'package:apiconsument/data/role.dart';
import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String middleName;
  final String surName;
  final String pesel;
  final String gender;
  final String birthDate;

  final int roleId;
  final int officeId;

  // final Office officeObj;
  // final Role roleObj;

  // var a, b;

  // User();
  User(this.firstName, this.middleName, this.surName, this.pesel, this.gender,
      this.birthDate, this.roleId, this.officeId);
  //  2137);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        middleName = json['middleName'],
        surName = json['surName'],
        pesel = json['pesel'],
        gender = json['gender'],
        birthDate = json['birthDate'],
        // roleId = json['roleId'], // inside another field
        // roleObj = json['roleId'],
        roleId = (json['roleId'])['id'],
        // roleId = json['roleId'],
        // roleId = roleObj.id,
        // roleId = json['roleId'], // inside another field
        officeId = json['officeId']['id'];
  // officeId = json['officeId'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'middleName': middleName,
        'surName': surName,
        'pesel': pesel,
        'gender': gender,
        'birthDate': birthDate,
        'roleId': roleId,
        'officeId': officeId,
      };

  Widget convertToWidgetList() {
    // List fields = [];
    Map<String, dynamic> myJsonFields = this.toJson();
    Iterable<String> myJsonFieldsKeys = myJsonFields.keys;
    Iterable<dynamic> myJsonFieldsValues = myJsonFields.values;
    return ListView.builder(
        itemCount: myJsonFields.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
                title: Text(
                  myJsonFieldsValues.elementAt(index).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(myJsonFieldsKeys.elementAt(index))),
          );
        });
  }
}
