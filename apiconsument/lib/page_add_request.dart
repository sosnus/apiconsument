import 'package:apiconsument/data/requestCar.dart';
import 'package:apiconsument/page_after_add_request.dart';
import 'package:flutter/material.dart';

import 'data/servers.dart';

class PageAddRequest extends StatefulWidget {
  final Server choosenServer;
  PageAddRequest({Key? key, required this.choosenServer}) : super(key: key);

  // PageAddUser({
  //   Key? key,
  //   required this.choosenServer,
  // }) : super(key: key);

  @override
  _PageAddRequestState createState() => _PageAddRequestState(choosenServer);
  // _PageAddRequestState createState() => _PageAddRequestState(choosenServer);
}

class _PageAddRequestState extends State<PageAddRequest> {
  Server choosenServer1 = Servers.serversList.first;
  _PageAddRequestState(Server choosenServer) {
    this.choosenServer1 = choosenServer;
  }

  // late Server choosenServer1;

  // _PageAddRequestState() {
  // this.choosenServer1 = choosenServer;
  // }

  // _PageAddUserState(this.choosenServer);

// @override
// State<StatefulWidget> createState() {
//   throw UnimplementedError();
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add: Request'),
      ),
      body: _addRequestForm(context),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _sendRequest(context),
        onPressed: () {},
        child: const Icon(Icons.send),
      ),
    );
  }

  TextEditingController formRequestorIdEditingController =
      TextEditingController();

  TextEditingController formBranchIdEditingController = TextEditingController();

  TextEditingController formCarModelEditingController = TextEditingController();

  TextEditingController formVehiclePrefferedEditingController =
      TextEditingController();

  _addRequestForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // setState(() {
    // });

    formBranchIdEditingController.text =
        widget.choosenServer.officeId.toString();
    // OfficeType _officeType = OfficeType.BO;
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: formRequestorIdEditingController,
                  decoration: const InputDecoration(
                    labelText: 'requestorId',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: formBranchIdEditingController,
                  decoration: const InputDecoration(
                    labelText: 'branchId',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: formCarModelEditingController,
                  decoration: const InputDecoration(
                    labelText: 'carModel',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: formVehiclePrefferedEditingController,
                  decoration: const InputDecoration(
                    labelText: 'vehiclePreffered',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                // Padding(
                // padding: const EdgeInsets.symmetric(
                // vertical: 16.0, horizontal: 16.0),
                // child:
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                      RequestCar tempRequestCar = RequestCar(
                          -1,
                          int.parse(formRequestorIdEditingController.text),
                          int.parse(formBranchIdEditingController.text),
                          formCarModelEditingController.text,
                          formVehiclePrefferedEditingController.text,
                          '-1',
                          '-1',
                          '-1',
                          '-1',
                          -1);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PageAfterAddRequest(
                            choosenServer: choosenServer1,
                            requestCar: tempRequestCar,
                            //tempRequestCar.toJsonOnly4field(),
                          ),
                        ),
                      );
                      // requestId, requestorId, branchId, carModel, vehiclePreffered, requestDate, requestStatus, approvedBy, approvedDate, branchRequestId)
                      // RequestCar(requestId, requestorId, branchId, carModel, vehiclePreffered, requestDate, requestStatus, approvedBy, approvedDate, branchRequestId)
                    }
                  },
                  child: Text('Submit'),
                ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // _sendRequest(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => PageAfterAddRequest(
  //         choosenServer: choosenServer,
  //         requestCar: tempRequestCar,
  //       ),
  //     ),
  //   );
  // }
}
