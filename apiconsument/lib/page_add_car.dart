import 'package:flutter/material.dart';

enum OfficeType { HQ, BO }

class PageAddCar extends StatelessWidget {
  const PageAddCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add: Car'),
      ),
      body: _addOfficeForm(context),
    );
  }

  _addOfficeForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    OfficeType _officeType = OfficeType.BO;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              // icon: Icon(Icons.person),
              // hintText: 'What do people call you?',
              labelText: 'Office name',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter city name';
              }
              return null;
            },
          ),
          ListTile(
            title: const Text('Branch Office'),
            leading: Radio<OfficeType>(
              value: OfficeType.BO,
              groupValue: _officeType,
              onChanged: (OfficeType? value) {},
            ),
          ),
          ListTile(
            title: const Text('Head Quater'),
            leading: Radio<OfficeType>(
              value: OfficeType.HQ,
              groupValue: _officeType,
              onChanged: (OfficeType? value) {},
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
