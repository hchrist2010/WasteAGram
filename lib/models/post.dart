import '../wasteagram.dart';

class WasteagramPost {
  String url;
  int amount;
  double latitude;
  double longitude;
  DateTime date;

  WasteagramPost(
      {this.url,
      this.amount,
      this.latitude,
      this.longitude,
      this.date});
}
