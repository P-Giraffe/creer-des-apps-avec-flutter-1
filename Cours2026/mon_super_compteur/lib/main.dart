import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes Petits Totaux',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Mes Petits Totaux'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _counterName = '';
  bool _isEditingCounterName = false;

  void _onCounterNameChanged(String value) {
    setState(() {
      _counterName = value;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = _counter - 1;
    });
  }

  void _toggleEditingCounterName() {
    setState(() {
      _isEditingCounterName = !_isEditingCounterName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const SizedBox(height: 24),
            if (_isEditingCounterName)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nom du compteur',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _onCounterNameChanged,
                  onSubmitted: (_) => _toggleEditingCounterName(),
                  onTapOutside: (_) => _toggleEditingCounterName(),
                ),
              )
            else
              Text(
                _counterName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            if (_isEditingCounterName == false)
              TextButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Modifier'),
                onPressed: _toggleEditingCounterName,
              ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (_counter > 10) Text('Ca commence à faire du bruit !'),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: .center,
              children: [
                Flexible(
                  child: IconButton.outlined(
                    onPressed: _decrementCounter,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.remove, size: 28),
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: _incrementCounter,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 28),
                  label: const Text('Augmenter le compteur'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
