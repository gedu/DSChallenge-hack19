import 'dart:async';

import 'package:dschallenge/home/remote_service.dart';
import 'package:dschallenge/models/challenge_item.dart';

enum HomeStatus { LOADING, SUCCESS, IDLE }

class ProviderState {
  List<ChallengeItem> challenges;
  HomeStatus status;

  ProviderState.success(this.challenges) : status = HomeStatus.SUCCESS;

  ProviderState.loading()
      : challenges = [],
        status = HomeStatus.LOADING;
}

class ChallengesProvider {
  RemoteService _service;

  List<ChallengeItem> _challenges;
  StreamController<ProviderState> _challengeController =
      StreamController.broadcast();

  Stream<ProviderState> get onChallenges => _challengeController.stream;

  ChallengesProvider(this._service);

  void fetchChallenges(String query) async {
    if (_challenges == null) {
      await _initialFetch();
    }

    if (query.isEmpty) {
      _challengeController.add(ProviderState.success(_challenges));
    } else {
      _filterChallengesBy(query);
    }
  }

  Future<void> _initialFetch() async {
    _challengeController.add(ProviderState.loading());

    final challenges = await _service.fetchAllChallenges();

    _challenges = challenges;
  }

  void _filterChallengesBy(String query) {
    final filteredList =
        _challenges.where((item) => item.tags.contains(query)).toList();
    _challengeController.add(ProviderState.success(filteredList));
  }

  void dispose() {
    _challengeController.close();
  }
}
