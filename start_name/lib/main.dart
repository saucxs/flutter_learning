import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'welcome to start name Flutter Demo',
      home: new RandomWords(),
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: new Text('你好，saucxs'),
      //   ),
      //   body: new Center(
      //     // child: new Text('Hello world'),
      //     // child: new Text(wordPair.asPascalCase),
      //     child: new RandomWords(),
      //   )
      // )
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // Widget build(BuildContext context) {
  //   final wordPair = new WordPair.random();
  //   return new Text(wordPair.asPascalCase);
  // }
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  // build 行
  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
  // build 
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Stratup Name Generator') ,
      ),
      body: _buildSuggestions(),
    );
  }
}
