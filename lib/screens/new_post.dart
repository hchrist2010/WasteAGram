import '../wasteagram.dart';
import '../main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:WasteAGram/size_blocks.dart';

class NewPost extends StatefulWidget {
  static const routName = 'NewPost';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File image;
  String url;
  double latitude;
  double longitude;
  int amount;
  DateTime date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initPage() async {
    date = DateTime.now();
    var location = Location();
    var userLocation = await location.getLocation();
    latitude = userLocation.latitude;
    longitude = userLocation.longitude;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${image.path}.${date.toString()}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();

    setState(() {});
  }

  Widget _appBar() {
    return AppBar(
      title: Text('New Post'),
      centerTitle: true,
    );
  }

  Widget _picture() {
    return Container(child: Image.file(image));
  }

  Widget _input() {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 5),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Amount of Waste',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter an amount';
          }
          return null;
        },
        onSaved: (String value) {
          amount = int.parse(value);
          setState(() {});
        },
      ),
    );
  }

  void _uploadToCloud() async {
    final databaseReference = Firestore.instance;
    await databaseReference.collection('posts').document().setData({
      'url': url,
      'amount': amount,
      'latitude': latitude,
      'longitude': longitude,
      'date': date.toString(),
    });
    totalAmountGlobal += amount;
    await databaseReference
        .collection('totalAmount')
        .document('totalAmount')
        .updateData({'totalAmount': totalAmountGlobal});
  }

  @override
  Widget build(BuildContext context) {
    if (image == null || latitude == null || longitude == null) {
      if (image == null) {
        initPage();
      }
      return Scaffold(
          appBar: _appBar(), body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _appBar(),
          body: Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _picture(),
                Form(
                  key: _formKey,
                  child: _input(),
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 180,
                  child: RaisedButton(
                      child: Icon(
                        Icons.cloud_upload,
                        size: 140,
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        } else {
                          _formKey.currentState.save();
                          _uploadToCloud();
                          Navigator.pop(context);
                          setState(() {
                            //totalAmount += amount;
                          });
                        }
                      }),
                )
              ],
            ),
          ));
    }
  }
}
