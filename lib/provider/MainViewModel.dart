import 'package:flutter/foundation.dart';
import 'package:github_search_with_flutter/models/QueryResult.dart';
import 'package:github_search_with_flutter/repository/gitRepo.dart';

class MainViewModel with ChangeNotifier {
  Future<QueryResult> futureQueryResult;

  void makeApiCallToBackend(String input) {
    futureQueryResult = searchRepos(input, "stars", "desc");
    notifyListeners();
  }
}
