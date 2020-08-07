import 'package:intl/intl.dart';
import '../models/post.dart';
import '../wasteagram.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:location/location.dart';

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
  DateTime date;

void getImage() async {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {});
    }

    void getLocation() async {
      var location = Location();
      var userLocation = await location.getLocation();
      latitude = userLocation.latitude;
      longitude = userLocation.longitude;
      setState(() {});
    }



  @override
  Widget build(BuildContext context) {
    if (image == null || latitude == null || longitude == null) {
      if(image == null){
        getImage();
      }
      date = DateTime.now();
      getLocation();
      return CircularProgressIndicator();
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Container(
              child: Column(
            children: <Widget>[
              Image.file(image),
              Row(
                children: <Widget>[
                  Spacer(),
                  Text('Latitude: ${latitude}'),
                  Spacer(),
                  Text('Longitude: ${longitude}'),
                  Spacer(),
                ],
              ),
              Text(DateFormat.yMMMMEEEEd().format(date))
            ],
          )),
        );
      }
    }
  }
