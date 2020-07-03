import 'package:flutter/material.dart';
import 'package:github_search_with_flutter/models/QueryResult.dart';
import 'package:github_search_with_flutter/provider/MainViewModel.dart';
import 'package:github_search_with_flutter/widgets/listItem.dart';
import 'package:github_search_with_flutter/widgets/searchBar.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider<MainViewModel>(
          create: (_) => MainViewModel(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context, listen: false);
    print("jeff rebuild MyHomePage");
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
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SearchBar(onTextReadyForSearch: (String val) {
              mainViewModel.makeApiCallToBackend(val);
            }),
            Expanded(
              child: Consumer<MainViewModel>(
                builder: (_, viewModel, __) => FutureBuilder<QueryResult>(
                    future: viewModel.futureQueryResult,
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
            ),
          ],
        ),
      ),
    );
  }
}
