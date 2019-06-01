import 'package:dschallenge/pinterest/api/client.dart';
import 'package:dschallenge/pinterest/pins_screen.dart';
import 'package:dschallenge/pinterest/state/PDKState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  static const pdkPlatform = const MethodChannel('pinterest.pdf/auth');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Do Something'),
      ),
      body: Center(
        child: Text('Hello'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAuth,
        child: Icon(Icons.file_upload),
      ),
    );
  }

  void _getAuth() async {
    try {
      final String result = await pdkPlatform.invokeMethod('startAuth');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<PDKState>(
                builder: (BuildContext context) => PDKState(Client()),
                child: PinsScreen(
                  accessToken: result,
                ),
              ),
        ),
      );
    } on PlatformException catch (e) {
      e.toString();
    }
  }
}
