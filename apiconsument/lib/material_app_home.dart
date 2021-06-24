import 'package:apiconsument/data/servers.dart';
import 'package:apiconsument/page_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api_service.dart';
// import 'data/api_serviceHQ.dart';

class MaterialAppHome extends StatelessWidget {
  final Server choosenServer;
  MaterialAppHome(this.choosenServer);

  @override
  Widget build(BuildContext context) {
    return Provider(
      // The initialized PostApiService is now available down the widget tree
      create: (_) => ApiService.create(choosenServer.address),
      // create: (_) => ApiServiceHQ.create(),
      // builder: (_) => ApiService.create(),
      // Always call dispose on the ChopperClient to release resources
      dispose: (context, ApiService service) => service.client.dispose(),
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: choosenServer.colorScheme,
        ),
        //   // colorScheme: choosenServer,
        //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        //   // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        title: choosenServer.type + ' ' + choosenServer.city,
        // home: PageHome(),
        home: PageMenu(
          choosenServer: choosenServer,
        ),
        // home: HomePage(),
      ),
    );
  }
}
