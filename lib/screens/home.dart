import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../wasteagram.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  static const routName = '/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int amount = 0;
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${title} - ${amount}'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data.documents[index];
                    //setAmount(post['amount']);
                    return ListTile(
                      leading: Text(DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(post['date']))),
                      title: Text(post['amount'].toString()),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
        Navigator.of(context).pushNamed(NewPost.routName);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
