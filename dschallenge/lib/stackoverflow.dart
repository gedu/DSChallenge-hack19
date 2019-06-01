import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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


class ListStackOverflowPostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
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

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Stack Overflow Questions"),
      ),
      body: futureBuilder,
    );
  }

  Future<List<StackOverflowQuestion>> _getData() async {
    var values = new List<StackOverflowQuestion>();

    final response = await http.get('https://api.stackexchange.com/2.2/search?page=1&pagesize=5&order=desc&sort=activity&tagged=flutter&intitle=chat&site=stackoverflow&key=crMKL43ChbI5neEFEi6A)A((');
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

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

 /* Future<List<StackOverflowQuestion>> fetchPosts() async {
    final response =
    await http.get('https://api.stackexchange.com/2.2/search?page=1&pagesize=1&order=desc&sort=activity&tagged=flutter&intitle=chat&site=stackoverflow&key=crMKL43ChbI5neEFEi6A)A((');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return StackOverflowQuestion.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }*/

/*
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(values[index]),
            ),
            new Divider(height: 2.0,),
          ],
        );
      },
    );
  }*/
}