import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  List dataTest = new List<String>.generate(10, (i) => "Test $i");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TEST"),
            Image(
                image: AssetImage('assets/images/github.png')
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: new Image.asset('assets/images/github.png'),
              onPressed: () {
                _stackOverFlowModalBottomSheet(context);
              },
            ),
            IconButton(
              icon: new Image.asset('assets/images/stackoverflow.png'),
              onPressed: () {
                _gitHubOverFlowModalBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _stackOverFlowModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new ListView.builder(
                itemCount: dataTest.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: new Icon(Icons.person),
                    title: new Text(dataTest[index]),
                    onTap: () => _launchURL('https://flutter.io'),
                  );
                }),
          );
        });
  }

  void _gitHubOverFlowModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new ListView.builder(
                itemCount: dataTest.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: new Icon(Icons.person),
                    title: new Text(dataTest[index]),
                    onTap: () => _launchURL('https://flutter.io'),
                  );
                }),
          );
        });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}