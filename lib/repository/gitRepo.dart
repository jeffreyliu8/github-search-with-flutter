import 'dart:async';
import 'dart:convert';
import 'package:github_search_with_flutter/constants.dart';
import 'package:github_search_with_flutter/models/QueryResult.dart';
import 'package:http/http.dart' as http;

Future<QueryResult> searchRepos(String query, String sort, String order) async {
  var queryParameters = {
    'q': query,
    'sort': sort,
    'order': order,
  };
  var uri =
      Uri.https(GITHUB_API_URL, GITHUB_API_GET_SEARCH_REPO, queryParameters);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return QueryResult.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to search Repos with status code ' +
        response.statusCode.toString());
  }
}
