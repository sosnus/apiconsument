import 'package:apiconsument/page_home.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'data/api_service.dart';
// import 'home_page.dart';

import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      // The initialized PostApiService is now available down the widget tree
      create: (_) => ApiService.create(),
      // builder: (_) => ApiService.create(),
      // Always call dispose on the ChopperClient to release resources
      dispose: (context, ApiService service) => service.client.dispose(),
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        ),
        title: 'Material App',
        home: PageHome(),
        // home: HomePage(),
      ),
    );
  }
}

void _setupLogging() {
  // Logger.root.level = Level.ALL;
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
