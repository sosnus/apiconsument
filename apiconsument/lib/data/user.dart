import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String middleName;
  final String surName;
  final String pesel;
  final String gender;
  final String birthDate;

  final int id;
  final int roleId;
  final int officeId;

  User(this.id, this.firstName, this.middleName, this.surName, this.pesel,
      this.gender, this.birthDate, this.roleId, this.officeId);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        middleName = json['middleName'],
        surName = json['surname'], //TO DO: remove capital N
        pesel = json['pesel'],
        gender = json['gender'],
        birthDate = json['birthDate'],
        roleId = (json['roleId'])['id'],
        officeId = json['officeId']['id'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'id': id,
        'middleName': middleName,
        'surname': surName,
        'pesel': pesel,
        'gender': gender,
        'birthDate': birthDate,
        'roleId': roleId,
        'officeId': officeId,
      };

  String toString() {
    return (';   id' +
        id.toString() +
        ';   firstName' +
        firstName +
        ';   middleName' +
        middleName +
        ';   surName' +
        surName +
        ';   pesel' +
        pesel +
        ';   gender' +
        gender +
        ';   birthDate' +
        birthDate +
        ';   roleId' +
        roleId.toString() +
        ';   officeId' +
        officeId.toString());
  }

  Widget convertToWidgetList() {
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
      },
    );
  }
}
