import 'package:flutter/material.dart';

class RequestCar {
  final int requestId;
  final int requestorId; // int, not object User
  final int branchId;
  final String carModel;
  final String vehiclePreffered;
  final String requestDate; //Not date; String

  final String requestStatus;
  final String approvedBy;
  final String approvedDate; //Not date; String
  final int branchRequestId;

  RequestCar(
    this.requestId,
    this.requestorId,
    this.branchId,
    this.carModel,
    this.vehiclePreffered,
    this.requestDate,
    this.requestStatus,
    this.approvedBy,
    this.approvedDate,
    this.branchRequestId,
  );

  //  RequestCar simple(

  //   requestorId,
  //   branchId,
  //   carModel,
  //   vehiclePreffered,

  // ){
  //   RequestCar()
  // }

  // RequestCar.createForm4Fields( this.requestId,
  //   this.requestorId,
  //   this.branchId,
  //   this.carModel,
  //   this.vehiclePreffered,
  //    ):
  //    {

  //    this.requestDate = "-1";

  //     this.requestStatus = ; this.approvedBy = null; this.approvedDate = null; this.branchRequestId = null;
  //    }

  // RequestCar.createForm4Fields( this.requestId,
  //   this.requestorId,
  //   this.branchId,
  //   this.carModel,
  //   this.vehiclePreffered,
  //    )
  //    {

  //    this.requestDate = null;
  //     this.requestStatus = null; this.approvedBy = null; this.approvedDate = null; this.branchRequestId = null;
  //    };

  String get getSomeInfo {
    return ("reqId: " +
        requestId.toString() +
        " who: " +
        requestorId.toString());
  }

  RequestCar.fromJson(Map<String, dynamic> json)
      : requestId = json['requestId'] == null ? "ERROR" : json['requestId'],
        requestorId = (json['requestorId'])['id'] == null
            ? "ERROR"
            : (json['requestorId'])['id'],
        branchId = json['branchId'] == null ? "ERROR" : json['branchId'],
        carModel = json['carModel'] == null ? "ERROR" : json['carModel'],
        vehiclePreffered = json['vehiclePreffered'] == null
            ? "ERROR"
            : json['vehiclePreffered'],
        requestDate =
            json['requestDate'] == null ? "ERROR" : json['requestDate'],
        requestStatus =
            json['requestStatus'] == null ? "no" : json['requestStatus'],
        approvedBy = json['approvedBy'] == null ? "no" : json['approvedBy'],
        approvedDate =
            json['approvedDate'] == null ? "no" : json['approvedDate'],
        branchRequestId =
            json['branchRequestId'] == null ? 1111 : json['branchRequestId'];

  Map<String, dynamic> toJson() => {
        'requestId': requestId,
        'requestorId': requestorId,
        'branchId': branchId,
        'carModel': carModel,
        'vehiclePreffered': vehiclePreffered,
        'requestDate': requestDate,
        'requestStatus': requestStatus,
        'approvedBy': approvedBy,
        'approvedDate': approvedDate,
        'branchRequestId': branchRequestId
      };

  Map<String, dynamic> toJsonOnly4field() => {
        // 'requestId': requestId,
        'requestorId': requestorId,
        'branchId': branchId,
        'carModel': carModel,
        'vehiclePreffered': vehiclePreffered,

        // 'requestDate': requestDate,
        // 'requestStatus': requestStatus,
        // 'approvedBy': approvedBy,
        // 'approvedDate': approvedDate,
        // 'branchRequestId': branchRequestId
      };
  Widget showAsCard() {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(
          requestId.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(carModel),
      ),
    );
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
                myJsonFieldsValues.elementAt(index) == Null
                    ? "ERROR"
                    : myJsonFieldsValues.elementAt(index).toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(myJsonFieldsKeys.elementAt(index))),
        );
      },
    );
  }
}
