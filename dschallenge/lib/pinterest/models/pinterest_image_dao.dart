class PinterestImageDao {
  final PinterestOriginal original;

  PinterestImageDao({this.original});

  PinterestImageDao.fromJson(Map<String, dynamic> json)
      : original = PinterestOriginal.fromJson(json['original']);
}

class PinterestOriginal {
  final String url;
  final int width;
  final int height;

  PinterestOriginal({this.url, this.width, this.height});

  PinterestOriginal.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        width = json['widget'],
        height = json['height'];
}
