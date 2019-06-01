import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dschallenge/home/challenges_list.dart';
import 'package:dschallenge/home/challenges_provider.dart';
import 'package:dschallenge/home/query_provider.dart';
import 'package:dschallenge/home/remote_service.dart';
import 'package:dschallenge/home/search_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  QueryProvider _query;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => QueryProvider(),
        ),
        Provider(
          builder: (context) =>
              ChallengesProvider(RemoteService(Firestore.instance)),
        )
      ],
      child: Consumer<QueryProvider>(builder: (context, value, _) {
        _query = value;
        return Scaffold(body: SafeArea(child: _content()));
      }),
    );
  }

  Widget _content() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SearchInput(_query),
          ChallengesList(_query),
        ],
      ),
    );
  }
}
