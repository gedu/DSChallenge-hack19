import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  static const pdkPlatform = const MethodChannel('pinterest.pdf/auth');

  var textString = 'Hello';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Do Something'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _getAuth,
          child: Text(textString),
        ),
      ),
    );
  }

  void _getAuth() async {
    String authResponse;
    try {
      final String result =
          await pdkPlatform.invokeMethod('startAuth');
      authResponse = 'Auth $result';
    } on PlatformException catch (e) {
      authResponse = "Failed to get auth token: '${e.message}'.";
    }

    setState(() {
      textString = authResponse;
    });
  }
}
