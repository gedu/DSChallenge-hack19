import 'package:dschallenge/pinterest/api/client.dart';
import 'package:dschallenge/pinterest/models/pinterest_page.dart';
import 'package:flutter/foundation.dart';

class PDKState with ChangeNotifier {
  PinterestPage _page;
  Client _client;

  PinterestPage get page => _page;

  set page(PinterestPage value) {
    _page = value;
    notifyListeners();
  }

  PDKState(this._client);

  void requestPins(String accessToken) {
    _client.oauth(accessToken).then((val) => page = val);
  }
}
