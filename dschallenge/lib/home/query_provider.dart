import 'package:flutter/material.dart';

class QueryProvider with ChangeNotifier {
  String _query = '';

  String get query => _query;

  set query(String text) {
    _query = text;
    notifyListeners();
  }
}
