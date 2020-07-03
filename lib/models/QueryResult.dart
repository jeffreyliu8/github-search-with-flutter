class QueryResult {
  final int totalCount;
  final int incompleteResults;
  final List<QueryItem> items;

  QueryResult({this.totalCount, this.incompleteResults, this.items});

  factory QueryResult.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<QueryItem> queryItems =
        list.map((i) => QueryItem.fromJson(i)).toList();

    return QueryResult(
      totalCount: json['total_count'],
      incompleteResults: json['incompleteResults'],
      items: queryItems,
    );
  }
}

class QueryItem {
  final String fullName;
  final String description;
  final Owner owner;
  final int stargazersCount;

  QueryItem(
      {this.fullName, this.description, this.owner, this.stargazersCount});

  factory QueryItem.fromJson(Map<String, dynamic> json) {
    var jsonOwner = json['owner'];

    var objOwner = Owner.fromJson(jsonOwner);

    return QueryItem(
      fullName: json['full_name'],
      description: json['description'],
      owner: objOwner,
      stargazersCount: json['stargazers_count'],
    );
  }
}

class Owner {
  final String avatarUrl;

  Owner({this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      avatarUrl: json['avatar_url'],
    );
  }
}
