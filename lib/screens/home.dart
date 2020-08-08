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

class _MyHomePageState extends State<MyHomePage> {
  int amount = 0;
  void setAmount(temp) {
    amount += temp;
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
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data.documents[index];
                    setAmount(post['amount']);
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
              return Container(child: CircularProgressIndicator());
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${title} - ${amount}'),
        centerTitle: true,
      ),
      body: _StreamBuilder(),
      floatingActionButton: _add_new(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
