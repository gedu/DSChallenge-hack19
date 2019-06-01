import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dschallenge/models/challenge_item.dart';

const CHALLENGES_PATH = 'challenges';
const TITLE_FIELD = 'title';
const DESCRIPTION_FIELD = 'desc';
const IMAGE_URL_FIELD = 'imageUrl';
const GITHUB_LINKS_FIELD = 'githubUrls';
const SCORE_FIELD = 'score';
const TAGS_FIELD = 'tags';

class RemoteService {
  Firestore _firestore;

  RemoteService(this._firestore);

  Future<List<ChallengeItem>> fetchAllChallenges() async {
    try {
      final docSnap =
          await _firestore.collection(CHALLENGES_PATH).getDocuments();
      final remoteChallenges =
          docSnap.documents.map((snap) => snap.data).toList();
      List<ChallengeItem> challenges = [];

      for (final maps in remoteChallenges) {
        print(maps[GITHUB_LINKS_FIELD]);
        List<String> links = [];
        // parsing List<dynamic> to List<String>
        for (final link in maps[GITHUB_LINKS_FIELD]) {
          links.add(link.toString());
        }

        final challenge = ChallengeItem(
            maps[TITLE_FIELD],
            maps[IMAGE_URL_FIELD],
            maps[DESCRIPTION_FIELD],
            maps[TAGS_FIELD],
            links,
            maps[SCORE_FIELD]);

        challenges.add(challenge);
      }

      return challenges;
    } catch (error) {
      print("ERROR fetching challenges: $error");
      return [];
    }
  }
}
