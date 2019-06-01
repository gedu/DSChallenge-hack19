import 'package:dschallenge/pinterest/models/pinterest_creator.dart';
import 'package:dschallenge/pinterest/models/pinterest_image_dao.dart';

class PinterestData {
  final String id;
  final PinterestCreator creator;
  final PinterestImageDao image;

  PinterestData({this.id, this.creator, this.image});

  PinterestData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        creator = PinterestCreator.fromJson(json['creator']),
        image = PinterestImageDao.fromJson(json['image']);
}
