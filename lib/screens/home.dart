import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../wasteagram.dart';
import 'package:intl/intl.dart';
import 'package:WasteAGram/size_blocks.dart';

class MyHomePage extends StatefulWidget {
  static const routName = '/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
  }

  File image;

  Widget _add_new() {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 15,
      width: SizeConfig.blockSizeHorizontal * 15,
      child: FloatingActionButton(
          child: Icon(
            Icons.camera_alt,
            size: SizeConfig.blockSizeHorizontal * 10,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(NewPost.routName);
          }),
    );
  }

  Widget _stream_builder() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('posts')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.documents.length > 1) {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length - 1,
                    itemBuilder: (context, index) {
                      var post = snapshot.data.documents[index];
                      return ListTile(
                        leading: Text(
                            DateFormat.yMMMMEEEEd()
                                .format(DateTime.parse(post['date'])),
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 5)),
                        trailing: Text(post['amount'].toString(),
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 5)),
                        onTap: () {
                          Navigator.of(context).pushNamed(PostDetails.routName,
                              arguments: WasteagramPost(
                                url: post['url'],
                                amount: post['amount'],
                                latitude: post['latitude'],
                                longitude: post['longitude'],
                                date: DateTime.parse(post['date']),
                              ));
                        },
                      );
                    });
              } else {
                return Loading(text: 'No Posts Currently');
              }
            } else {
              return Loading(text: 'Loading...');
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // if (amountGlobal != null) {
    return Scaffold(
      appBar: customAppBar(),
      body: _stream_builder(),
      floatingActionButton: _add_new(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Loading extends StatelessWidget {
  Loading({
    Key key, this.text
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text,
        style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 5
        )),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3
        ),
        CircularProgressIndicator(),
      ],
    )));
  }
}

Widget customAppBar() {
  return AppBar(
    title: StreamBuilder(
        stream: Firestore.instance.collection('totalAmount').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          int totalAmount = snapshot.data.documents[0]['totalAmount'];
          totalAmountGlobal = totalAmount.toInt();
          return Text('WasteAGram - ${totalAmount.toString()}');
        }),
    centerTitle: true,
  );
}
