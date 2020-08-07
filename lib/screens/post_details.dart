import 'package:intl/intl.dart';
import '../models/post.dart';
import '../wasteagram.dart';
import 'package:intl/intl.dart';

class PostDetails extends StatelessWidget {
  static const routName = 'PostDetails';
  PostDetails(this.post);
  final WasteagramPost post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${title}'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(
              DateFormat.yMMMMEEEEd().format(post.date),
            ),
            Image(image: NetworkImage(post.url)),
            Text('Items: ${post.amount}'),
            Row(children: [
              Spacer(),
              Text('Longitude: ${post.longitude}'),
              Spacer(),
              Text('Latitude: ${post.latitude}'),
              Spacer(),
            ])
          ],
        ));
  }
}
