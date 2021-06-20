import 'dart:convert';

import 'package:apiconsument/single_post_page.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';

class PageAddUser extends StatefulWidget {
  PageAddUser({
    Key? key,
  }) : super(key: key);

  @override
  _PageAddUserState createState() => _PageAddUserState();
}

class _PageAddUserState extends State<PageAddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new user'),
      ),
      body: _formAddNewUser(context),
      floatingActionButton: FloatingActionButton(
        // onPressed: () {},
        //  => _sendRequest(context),
        onPressed: () => _sendRequest(context),
        child: const Icon(Icons.send),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  List roleList = [];

  TextEditingController form_id_EditingController = TextEditingController();

  TextEditingController form_first_name_EditingController =
      TextEditingController();

  TextEditingController form_middle_name_EditingController =
      TextEditingController();

  TextEditingController form_surname_name_EditingController =
      TextEditingController();

  TextEditingController form_gender_EditingController = TextEditingController();

  TextEditingController form_pesel_EditingController = TextEditingController();

  _formAddNewUser(BuildContext context) {
    // roleL
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          TextFormField(
            controller: form_id_EditingController,
            // initialValue: "44",
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              // icon: Icon(Icons.person),
              // hintText: 'What do people call you?',
              labelText: 'Id (id)',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if (int.tryParse(value) == null) {
                return 'Can not parsing, only numbers allowed';
              }
              return null;
            },
          ),
          TextFormField(
            controller: form_first_name_EditingController,
            decoration: const InputDecoration(
              labelText: 'First Name (first_name)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: form_middle_name_EditingController,
            decoration: const InputDecoration(
              labelText: 'Middle Name (middle_name)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: form_surname_name_EditingController,
            decoration: const InputDecoration(
              labelText: 'Surname (surname)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: form_gender_EditingController,
            decoration: const InputDecoration(
              labelText: 'Gender (gender) (char)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          roleDropdownWidget(),
          TextFormField(
            controller: form_pesel_EditingController,
            decoration: const InputDecoration(
              labelText: 'Pesel (pesel) (10 to 12 numbers)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          // ElevatedButton(
          //   onPressed: processingForm(context),
          //   child: Text('Submit'),
          // ),
        ],
      ),
    );
  }

  String dropdownValue = 'One';
  Widget roleDropdownWidget() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      // style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      // height: 2,
      // color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _sendRequest(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //     // If the form is valid, display a snackbar. In the real world,
      //     // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    print(form_id_EditingController.text);
    print(form_first_name_EditingController.text);
    print(form_middle_name_EditingController.text);
    print(form_surname_name_EditingController.text);
    print(form_gender_EditingController.text);
    print(form_pesel_EditingController.text);
  }
}
// }
