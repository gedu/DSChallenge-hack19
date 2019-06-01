import 'package:dschallenge/pinterest/api/client.dart';
import 'package:dschallenge/pinterest/state/PDKState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PinsScreen extends StatefulWidget {
  final String accessToken;

  PinsScreen({@required this.accessToken});

  @override
  _PinsScreenState createState() => _PinsScreenState();
}

class _PinsScreenState extends State<PinsScreen> {
  static const pdkPlatform = const MethodChannel('pinterest.pdf/auth');

  @override
  Widget build(BuildContext context) {
    Provider.of<PDKState>(context).requestPins(widget.accessToken);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your pins'),
      ),
      body: Consumer<PDKState>(
          builder: (BuildContext context, PDKState value, Widget child) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
            ),
            itemCount: value.page?.data?.length ?? 0,
            itemBuilder: (context, index) => Image.network(value.page.data[index].image.original.url));
      }),
    );
  }
}
