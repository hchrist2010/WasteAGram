import 'package:cloud_firestore/cloud_firestore.dart';
import 'wasteagram.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

final String title = 'WasteAGram';
int totalAmount = 0;
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final routes = {
    MyHomePage.routName: (context) => MyHomePage(),
    PostDetails.routName: (context) =>
        PostDetails(ModalRoute.of(context).settings.arguments),
    NewPost.routName: (context) => NewPost(),
  };

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: MyApp.routes,
//      home: MyHomePage(),
//      home: fakeHomePage(),
    );
  }
}

