import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page/home_page.dart';
import 'models/person.dart';
import 'page/new_page.dart';
import 'page/groups_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Persons(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: HomePage(),
        routes: {
          NewPage.route: (ctx) => NewPage(),
          RelationsPage.route: (ctx) => RelationsPage(),
        },
      ),
    );
  }
}
