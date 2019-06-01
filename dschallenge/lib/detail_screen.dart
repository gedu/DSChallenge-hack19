import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class StackOverflowQuestion {
  final int questionId;
  final String title;
  final String link;

  StackOverflowQuestion({this.questionId, this.title, this.link});

  factory StackOverflowQuestion.fromJson(Map<String, dynamic> json) {
    return StackOverflowQuestion(
      questionId: json['questionId'],
      title: json['title'],
      link: json['link'],
    );
  }
}

class DetailScreen extends StatelessWidget {
  List dataGitTest = new List<String>.generate(10, (i) => "https://github.com/explore");
  List dataStackOFTest = new List<String>.generate(10, (i) => "https://stackoverflow.com");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TEST"),
            Image(image: AssetImage('assets/images/github.png'))
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
              iconSize: 50,
              onPressed: () {
                _gitHubFlowModalBottomSheet(context);
              },
            ),
            IconButton(
              icon: new Image.asset('assets/images/stackoverflow.png'),
              iconSize: 50,
              onPressed: () {
                _stackOverModalBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _gitHubFlowModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new ListView.builder(
                itemCount: dataGitTest.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: new Icon(Icons.person),
                    title: new Text(dataGitTest[index]),
                    onTap: () => _launchURL(dataGitTest[index]),
                  );
                }),
          );
        });
  }


  void _stackOverModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return new FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return new Center(
                      child: CircularProgressIndicator()
                  );
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return createListView(context, snapshot);
              }
            },
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

  Future<List<StackOverflowQuestion>> _getData() async {
    var values = new List<StackOverflowQuestion>();

    final response = await http.get('https://api.stackexchange.com/2.2/search?page=1&pagesize=10&order=desc&sort=activity&tagged=flutter&intitle=chat&site=stackoverflow&key=crMKL43ChbI5neEFEi6A)A((');
    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body)['items'];
      items.forEach((item) {
        values.add(StackOverflowQuestion.fromJson(item));
      });
    }
    return values;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<StackOverflowQuestion> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              leading: Icon(Icons.question_answer),
              title: Text(values[index].title),
              onTap: () {
                _launchURL(values[index].link);
              },
            ),
            new Divider(height: 2.0,),
          ],
        );
      },
    );
  }
}