import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_test_harness2/models/user.dart';
import 'package:flutter_test_harness2/models/event.dart';

import 'package:flutter_test_harness2/pages/counter_page.dart';
import 'package:flutter_test_harness2/pages/user_page.dart';
import 'package:flutter_test_harness2/pages/event_page.dart';
import 'package:flutter_test_harness2/services/data_provider.dart';

// Main app and Pages for Tab Layout
void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => DataProvider()),
              FutureProvider(create: (_) => UserProvider().loadUserData()),
              StreamProvider(
                  create: (_) => EventProvider().intStream(), initialData: 0)
            ],
            child: DefaultTabController(
                length: 3,
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Provider Demo"),
                      bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.add)),
                          Tab(icon: Icon(Icons.person)),
                          Tab(icon: Icon(Icons.message)),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        CounterPage(),
                        UserPage(),
                        EventPage(),
                      ],
                    ),
                  ),
                ))));
  }
}
