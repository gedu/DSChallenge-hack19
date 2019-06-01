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

  StreamController<ProviderState> _challengeController =
      StreamController.broadcast();

  Stream<ProviderState> get onChallenges => _challengeController.stream;

  ChallengesProvider(this._service);

  void fetchChallenges() async {
    _challengeController.add(ProviderState.loading());

    final challenges = await _service.fetchAllChallenges();

    _challengeController.add(ProviderState.success(challenges));
  }

  void dispose() {
    _challengeController.close();
  }
}
