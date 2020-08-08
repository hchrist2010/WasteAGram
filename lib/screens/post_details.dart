import 'package:intl/intl.dart';
import '../models/post.dart';
import '../wasteagram.dart';
import 'package:intl/intl.dart';
import 'package:WasteAGram/size_blocks.dart';

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
        body: Container(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                child: Text(
                  DateFormat.yMMMMEEEEd().format(post.date),
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5
                  ),
                ),
              ),
              Image(image: NetworkImage(post.url)),
              Text('Items: ${post.amount}',
              style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 7)),
              Text('(${post.longitude} ,       ${post.latitude})',
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5)),
              ])
          ),
        );
  }
}
