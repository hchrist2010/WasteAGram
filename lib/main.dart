import 'wasteagram.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';


final String title = 'WasteAGram';
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final routes = {
    MyHomePage.routName: (context) => MyHomePage(),
    PostDetails.routName: (context) => PostDetails(ModalRoute.of(context).settings.arguments),
    NewPost.routName: (context) => NewPost(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: routes,
//      home: MyHomePage(),
    );
  }
}
