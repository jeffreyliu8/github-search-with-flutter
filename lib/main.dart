import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_search_with_flutter/models/QueryResult.dart';
import 'package:github_search_with_flutter/widgets/listItem.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController eCtrl = new TextEditingController();

  Future<QueryResult> futureQueryResult;

  void _incrementCounter(String input) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      futureQueryResult = searchRepos(input, "stars", "desc");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: eCtrl,
                    onSubmitted: (text) {
                      _incrementCounter(text);
//                      litems.add(text);
//                      eCtrl.clear();
//                      setState(() {});
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _incrementCounter(eCtrl.text);
                  },
                  child: Text(
                    "Search",
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<QueryResult>(
                  future: futureQueryResult,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.items.length,
                            itemBuilder: (BuildContext bc, int index) {
                              return ListItem(
                                queryItem: snapshot.data.items[index],
                              );
                            });
                      } else {
                        return Text("No results");
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Container();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

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
