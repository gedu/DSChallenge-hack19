import 'package:dschallenge/pinterest/models/pinterest_data.dart';

class PinterestPage {
  final List<PinterestData> data;

  PinterestPage({this.data});

  PinterestPage.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List)
            .map((item) => PinterestData.fromJson(item))
            .toList();
}
