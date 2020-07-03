import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_search_with_flutter/models/QueryResult.dart';

class ListItem extends StatelessWidget {
  final QueryItem queryItem;

  ListItem({Key key, this.queryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image.network(
              queryItem.owner?.avatarUrl ?? "",
              width: 64,
              height: 64,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            queryItem.fullName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "★" + queryItem.stargazersCount.toString(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(queryItem.description ?? "",
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
