import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onTextReadyForSearch;
  final TextEditingController eCtrl = new TextEditingController();

  SearchBar({Key key, @required this.onTextReadyForSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: eCtrl,
            onSubmitted: (text) {
              onTextReadyForSearch(text);
            },
          ),
        ),
        RaisedButton(
          onPressed: () {
            onTextReadyForSearch(eCtrl.text);
          },
          child: Text(
            "Search",
          ),
        )
      ],
    );
  }
}
