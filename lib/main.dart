import 'package:flutter/material.dart';

import 'package:least/Pages/SCANNERPAGE.dart';

import 'Pages/homepage.dart';

import 'models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Homepage(),
        routes: {
          '/homepage': (_) => Homepage(),
          '/scanner': (_) => ScannerPage()
        }));
  }
}
