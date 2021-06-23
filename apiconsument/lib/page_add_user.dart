import 'dart:convert';

import 'package:apiconsument/page_delete_user.dart';
import 'package:chopper/chopper.dart';
import 'package:intl/intl.dart';
import 'package:apiconsument/data/roles_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
import 'data/user.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'page_after_add_user.dart';

enum Gender { M, W }

Gender? _selectedGender = Gender.M;
int selectedOfficeId = -1;
String dateAsString = "Change birth date)";

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

  TextEditingController form_temporaryId_toDelete_this_field_EditingController =
      TextEditingController(); // form_id_EditingController

  TextEditingController form_first_name_EditingController =
      TextEditingController();

  TextEditingController form_middle_name_EditingController =
      TextEditingController();

  TextEditingController form_surname_name_EditingController =
      TextEditingController();

  TextEditingController form_gender_EditingController = TextEditingController();

  TextEditingController form_pesel_EditingController =
      TextEditingController(text: "11111111111");

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
            controller: form_temporaryId_toDelete_this_field_EditingController,
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
          // TextFormField(
          //   controller: form_gender_EditingController,
          //   decoration: const InputDecoration(
          //     labelText: 'Gender (gender) (char)',
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          // ),
          Text("todo:"),
          Text("Radiobutton Role"),
          Text("Radiobutton Office:"),
          // roleRadiobuttonGender(),
          // roleDropdownWidget(),
          ElevatedButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Are You sure to delete user?'),
                      content: SizedBox(
                        height: 200,
                        width: 300,
                        child: Container(
                          child: _buildList(context),
                          // child: ListView(
                          // crossAxisAlignment:
                          // CrossAxisAlignment.stretch,
                          // children: <Widget>[_buildList(context)]),
                        ),
                      ),
                      // ),
                      // content:  _buildList(context),
                      //HEHRE Text('User id: ' + "1"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel2'),
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  ),
              child: Text("Select office")),
          ElevatedButton(
              //form_officeId_EditingController
              onPressed: () => {
                    form_officeId_EditingController.text =
                        selectOfficeWindow().toString()
                    // selectedOfficeId = selectOfficeWindow()
                  },
              child: Text("🏢 Selected office: " +
                  form_officeId_EditingController.text)),
          // roleSelectNewWindow(),
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
                setState(() {
                  selectDatetime()
                      .then((value) => form_birthDate_EditingController.text =
                          // dateAsString =
                          DateFormat('yyyy-MM-dd').format(value!));
                  // dateAsString;
                });
              },
              child: Text(
                //form_birthDate_EditingController.text
                "📅    " + form_birthDate_EditingController.text,
              )),
          // TextFormField(
          //   controller: form_birthDate_EditingController,
          //   decoration: const InputDecoration(
          //     labelText: 'birth, birth, birth',
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          // ),
        ],
      ),
    );
  }

  String dropdownValue = RolesCollection.getRole(0).asString();

  Widget roleRadiobuttonGender() => Column(
        children: <Widget>[
          ListTile(
            title: const Text('Man'),
            leading: Radio<Gender>(
              value: Gender.M,
              groupValue: _selectedGender,
              onChanged: (Gender? value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Woman'),
            leading: Radio<Gender>(
              value: Gender.W,
              groupValue: _selectedGender,
              onChanged: (Gender? value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
        ],
      );

  Widget roleRadiobuttonRole() => Column(
        children: <Widget>[
          ListTile(
            title: const Text('Man'),
            leading: Radio<Gender>(
              value: Gender.M,
              groupValue: _selectedGender,
              onChanged: (Gender? value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Woman'),
            leading: Radio<Gender>(
              value: Gender.W,
              groupValue: _selectedGender,
              onChanged: (Gender? value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
        ],
      );

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

    String extractFromEnum(Gender g) {
      switch (g) {
        case Gender.M:
          return "M";
        case Gender.W:
          return "W";
      }
    }

    User myUser = new User(
      int.parse(form_temporaryId_toDelete_this_field_EditingController.text),
      form_first_name_EditingController.text,
      form_middle_name_EditingController.text,
      form_surname_name_EditingController.text,
      form_pesel_EditingController.text,
      // form_gender_EditingController.text,
      extractFromEnum(_selectedGender!),
      dateAsString,
      // form_birthDate_EditingController.text,
      1,
      1,
      // int.parse(form_roleId_EditingController.text),
      // int.parse(form_officeId_EditingController.text),
    );
    print(myUser.toString());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageAfterAddUser(user: myUser),
      ),
    );
    // Provider.of<ApiService>(context).postNewUser(myUser.toJson());
  }

  Future<DateTime?> selectDatetime() async {
    return DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      print('confirm $date');
    },
        currentTime: DateTime.utc(1990, 6, 15, 23, 12, 34),
        locale: LocaleType.en);
  }

  int selectOfficeWindow() {
    _showMyDialog();
    setState(() {
      selectedOfficeId++;
    });
    return selectedOfficeId;
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).usersAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List posts = json.decode(snapshot.data!.bodyString);
          // return Text("S\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nSSS");
          // return ScrollView();
          return Container(
              width: double.infinity,
              height: double.infinity,
              child: _buildPosts(context, posts));
          // return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // return Text(index.toString());
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index]['surName'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index]['firstName']),
            onTap: () => Navigator.pop(context, 'Cancel'),
            // onTap: () => _navigateToOneUserPage(context, posts[index]['id']),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    final Future<Widget> _calculation = Future<Widget>.delayed(
      const Duration(seconds: 2),
      () => Text('Data Loaded'),
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // future:
          // future: Provider.of<ApiService>(context).userById(int.parse(user_id)),
          title: const Text('AlertDialog Title'),
          content: FutureBuilder<Widget>(
            future: _calculation,
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${snapshot.data}'),
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
