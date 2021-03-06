import 'package:flutter/material.dart';

class Car {
  final String plateNumber; // key
  final String licenseNumber;
  final String model;
  final String type;
  final String vinNumber;
  final bool assigned;

  Car(this.plateNumber, this.licenseNumber, this.model, this.type,
      this.vinNumber, this.assigned);

  Car.fromJson(Map<String, dynamic> json)
      : plateNumber = json['plateNumber'],
        licenseNumber = json['licenseNumber'],
        model = json['model'],
        type = json['type'],
        vinNumber = json['vinNumber'],
        assigned = json['assigned'] == null ? false : json['assigned'];

  Map<String, dynamic> toJson() => {
        'plateNumber': plateNumber,
        'licenseNumber': licenseNumber,
        'model': model,
        'type': type,
        'vinNumber': vinNumber,
        'assigned': assigned,
      };

  @override
  String toString() {
    return '/n \n plateNumber  ' +
        plateNumber +
        '\nlicenseNumber' +
        licenseNumber +
        '\nmodel         ' +
        model +
        '\ntype        ' +
        type +
        '\nvinNumber  ' +
        vinNumber +
        '\nassigned ' +
        assigned.toString();
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
