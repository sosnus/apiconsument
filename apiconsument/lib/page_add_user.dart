import 'package:intl/intl.dart';
import 'package:apiconsument/data/roles_collection.dart';
import 'package:flutter/material.dart';

import 'data/user.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

  TextEditingController form_birthDate_EditingController =
      TextEditingController();

  TextEditingController form_roleId_EditingController = TextEditingController();

  TextEditingController form_officeId_EditingController =
      TextEditingController();

  _formAddNewUser(BuildContext context) {
    // roleL
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          TextFormField(
            controller: form_id_EditingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
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
          ElevatedButton(
              onPressed: () {
                selectDatetime().then((value) =>
                    form_birthDate_EditingController.text =
                        DateFormat('yyyy-MM-dd').format(value!));
              },
              child: Text(
                "📅 " + form_birthDate_EditingController.text,
              )),
          TextFormField(
            controller: form_birthDate_EditingController,
            decoration: const InputDecoration(
              labelText: 'birth, birth, birth',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  String dropdownValue = RolesCollection.getRole(0).asString();
  Widget roleDropdownWidget() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        RolesCollection.getRole(0).asString(),
        RolesCollection.getRole(1).asString()
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _sendRequest(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    User tempUser = new User(
      form_first_name_EditingController.text,
      form_middle_name_EditingController.text,
      form_surname_name_EditingController.text,
      form_pesel_EditingController.text,
      form_gender_EditingController.text,
      form_birthDate_EditingController.text,
      int.parse(form_roleId_EditingController.text),
      int.parse(form_officeId_EditingController.text),
    );
  }

  Future<DateTime?> selectDatetime() async {
    return DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      print('confirm $date');
    },
        currentTime: DateTime.utc(1990, 12, 31, 23, 12, 34),
        locale: LocaleType.en);
  }
}
