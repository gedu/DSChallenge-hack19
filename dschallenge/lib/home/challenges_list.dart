import 'package:dschallenge/home/challenges_provider.dart';
import 'package:dschallenge/home/query_provider.dart';
import 'package:dschallenge/models/challenge_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengesList extends StatelessWidget {
  final QueryProvider _query;
  ChallengesProvider _challenges;

  ChallengesList(this._query);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengesProvider>(builder: (context, value, _) {
      _challenges = value;
      _challenges.fetchChallenges(_query.query);
      return StreamBuilder(
        stream: _challenges.onChallenges,
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return Container();
          }

          return _handleChallengeStates(asyncSnapshot.data);
        },
      );
    });
  }

  Widget _handleChallengeStates(ProviderState state) {
    switch (state.status) {
      case HomeStatus.LOADING:
        return _loadingList();
      case HomeStatus.SUCCESS:
        return _displayList(state.challenges);
      default:
        return Container();
    }
  }

  Widget _loadingList() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _displayList(List<ChallengeItem> challenges) {
    return Expanded(
      child: ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            return _itemList(challenges[index]);
          }),
    );
  }

  Widget _itemList(ChallengeItem item) {
    return Container(
      color: Colors.indigo,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(item.title),
          Text(item.desc),
        ],
      ),
    );
  }
}
