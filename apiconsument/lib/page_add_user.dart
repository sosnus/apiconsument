import 'dart:convert';
import 'data/api_service.dart';
import 'data/servers.dart';
import 'data/user.dart';
import 'package:apiconsument/data/roles_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'page_after_add_user.dart';

enum Gender { M, W }

Gender? _selectedGender = Gender.M;
int selectedOfficeId = -1;
int selectedRoleId = -1;

String selectedOfficeName = "(please select)";
String dateAsString = "Change birth date)";

class PageAddUser extends StatefulWidget {
  final Server choosenServer;

  PageAddUser({
    Key? key,
    required this.choosenServer,
  }) : super(key: key);

  @override
  _PageAddUserState createState() => _PageAddUserState(choosenServer);
}

class _PageAddUserState extends State<PageAddUser> {
  final Server choosenServer;

  _PageAddUserState(this.choosenServer);

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

  TextEditingController formTemporartUserIdEditingController =
      TextEditingController();

  TextEditingController formFirstNameEditingController =
      TextEditingController();

  TextEditingController formMiddleNameEditingController =
      TextEditingController();

  TextEditingController formSurnameEditingController = TextEditingController();

  TextEditingController formGenderEditingController = TextEditingController();

  TextEditingController formPeselEditingController =
      TextEditingController(text: "11111111111");

  TextEditingController formBirtDateEditingController = TextEditingController();

  TextEditingController formRoleIdEditingController = TextEditingController();

  TextEditingController formOfficeIdEditingController = TextEditingController();

  _formAddNewUser(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          TextFormField(
            controller: formTemporartUserIdEditingController,
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
            controller: formFirstNameEditingController,
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
            controller: formMiddleNameEditingController,
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
            controller: formSurnameEditingController,
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
          roleRadiobuttonGender(),
          roleDropdownWidget(),
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
                        ),
                      ),
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
              child: Text("🏢 Office: " +
                  selectedOfficeId.toString() +
                  ' ' +
                  selectedOfficeName)),
          TextFormField(
            controller: formPeselEditingController,
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
                  selectDatetime().then((value) => formBirtDateEditingController
                      .text = DateFormat('yyyy-MM-dd').format(value!));
                });
              },
              child: Text(
                "📅    " + formBirtDateEditingController.text,
              )),
        ],
      ),
    );
  }

  String dropdownValue = RolesCollection.getRole(0).asString();

  Widget roleRadiobuttonGender() => Column(
        children: <Widget>[
          ListTile(
            title: const Text('M'),
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
            title: const Text('W'),
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
        setState(
          () {
            dropdownValue = newValue!;
            if (RolesCollection.getRole(0).asString() == dropdownValue) {
              selectedRoleId = RolesCollection.getRole(0).id;
            } else {
              selectedRoleId = RolesCollection.getRole(1).id;
            }
          },
        );
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
        int.parse(formTemporartUserIdEditingController.text),
        formFirstNameEditingController.text,
        formMiddleNameEditingController.text,
        formSurnameEditingController.text,
        formPeselEditingController.text,
        extractFromEnum(_selectedGender!),
        formBirtDateEditingController.text,
        selectedRoleId,
        selectedOfficeId);
    print(myUser.toString());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PageAfterAddUser(choosenServer: choosenServer, user: myUser),
      ),
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
        currentTime: DateTime.utc(1990, 6, 15, 23, 12, 34),
        locale: LocaleType.en);
  }

  FutureBuilder<Response> _buildList(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ApiService>(context).officeAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List posts = json.decode(snapshot.data!.bodyString);
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: _buildPosts(context, posts),
          );
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
        return Card(
          elevation: 4,
          child: ListTile(
              title: Text(
                posts[index]['id'].toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(posts[index]['city']),
              onTap: () => {
                    Navigator.pop(context, 'type'),
                    setState(() {
                      selectedOfficeName = posts[index]['city'];
                      selectedOfficeId = posts[index]['id'];
                    })
                  }),
        );
      },
    );
  }
}
