import 'dart:io';

import 'package:dschallenge/pinterest/models/pinterest_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Client {
  final String baseUrl = 'api.pinterest.com';

  Future<PinterestPage> oauth(String accessToken) async {
    final queryParams = {
      'access_token': accessToken,
      'fields': 'id,image,creator'
    };

    final uri = Uri.https(baseUrl, "/v1/me/pins", queryParams);

    return http.get(uri).then((response) {
      if (response.statusCode == 200) {
        return PinterestPage.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Status Code : ${response.statusCode}');
      }
    });
  }
}
