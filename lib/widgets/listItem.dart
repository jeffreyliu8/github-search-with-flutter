import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_search_with_flutter/models/QueryResult.dart';

class ListItemState extends State<ListItem> {
  QueryItem _queryItem;

  ListItemState(this._queryItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image.network(
              _queryItem.owner?.avatarUrl ?? "",
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
                            _queryItem.fullName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "★" + _queryItem.stargazersCount.toString(),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_queryItem.description ?? "",
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

class ListItem extends StatefulWidget {
  final QueryItem queryItem;

  ListItem({Key key, this.queryItem}) : super(key: key);

  @override
  createState() => ListItemState(queryItem);
}
