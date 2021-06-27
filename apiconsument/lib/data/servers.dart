import 'package:flutter/material.dart';

class Servers {
  static List<Server> serversList = [
    Server(
      "HQ",
      "Warsaw",
      "https://iap-warsaw-hq.azurewebsites.net",
      ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      Icons.star,
      1,
    ),
    Server(
      "BO",
      "Lodz",
      "https://iap-lodz-bo.azurewebsites.net",
      ColorScheme.fromSwatch(primarySwatch: Colors.green),
      Icons.star_half,
      2,
    )
  ];
}

class Server {
  final String type;
  final String city;
  final String address;
  final ColorScheme colorScheme;
  final IconData icon;
  final int officeId;
  Server(
    this.type,
    this.city,
    this.address,
    this.colorScheme,
    this.icon,
    this.officeId,
  );
}
