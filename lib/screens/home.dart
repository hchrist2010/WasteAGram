import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../wasteagram.dart';
import 'package:intl/intl.dart';
import 'package:WasteAGram/size_blocks.dart';

class MyHomePage extends StatefulWidget {
  static const routName = '/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class GetTotalAmount {
  getAmount() {
    return Firestore.instance.collection('totalAmount').getDocuments();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var amount;
  @override
  initState() {
    super.initState();
    initTotalAmount();
  }

  void initTotalAmount() async {
    await GetTotalAmount().getAmount().then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        amount = docs.documents[0].data;
      }
    });
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

  Widget _StreamBuilder() {
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
                return Center(child: CircularProgressIndicator());
              }
            }else {
                return Center(child: CircularProgressIndicator());
              }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (amount != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${title} - ${amount['totalAmount'].toString()}'),
          centerTitle: true,
        ),
        body: _StreamBuilder(),
        floatingActionButton: _add_new(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    } else {
      return Scaffold(body: CircularProgressIndicator());
    }
  }
}
