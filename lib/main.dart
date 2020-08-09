import 'wasteagram.dart';

final String title = 'WasteAGram';
int totalAmountGlobal = 0;
void main() {
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
      title: 'WasteAGram',
      theme: ThemeData.dark(),
      routes: MyApp.routes,
    );
  }
}

