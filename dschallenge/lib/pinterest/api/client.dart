import 'package:dschallenge/pinterest/models/pinterest_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Client {
  final String baseUrl = 'https://api.pinterest.com/';

  Future<PinterestPage> oauth(String accessToken) async {
    return http
        .get('${baseUrl}v1/me/pins/?access_token=$accessToken&fields=id,image,creator')
        .then((response) {
      if (response.statusCode == 200) {
        return PinterestPage.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Status Code : ${response.statusCode}');
      }
    });
  }
}
