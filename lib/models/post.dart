import '../wasteagram.dart';

class WasteagramPost {
  String url;
  int amount;
  int latitude;
  int longitude;
  DateTime date;

  WasteagramPost(
      {this.url,
      this.amount,
      this.latitude,
      this.longitude,
      this.date});
}
