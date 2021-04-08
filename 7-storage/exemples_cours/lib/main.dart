import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 10;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _readClickCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: _saveClickCount,
                child: Text("Enregistrer le score")),
            ElevatedButton(
                onPressed: _readClickCount, child: Text("Charger le score"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  _saveClickCount() async {
    File file = await getClickCountFile();
    await file.writeAsString("$_counter");
    print(file.path);
  }

  Future<File> getClickCountFile() async {
    final folder = await getApplicationDocumentsDirectory();
    final folderPath = folder.path;
    final file = File("$folderPath/clickCount.txt");
    return file;
  }

  _readClickCount() async {
    File file = await getClickCountFile();
    if (file.existsSync()) {
      final loadedText = await file.readAsString();
      final loadedClickCount = int.tryParse(loadedText);
      if (loadedClickCount != null) {
        setState(() {
          _counter = loadedClickCount;
        });
      }
    }
  }
}
