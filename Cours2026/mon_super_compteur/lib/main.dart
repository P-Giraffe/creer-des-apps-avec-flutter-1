import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int? _goal;

  void _onCounterNameChanged(String value) {
    setState(() {
      _counterName = value;
    });
  }

  void _onGoalChanged(String value) {
    setState(() {
      _goal = int.tryParse(value);
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
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _counterName,
                      decoration: const InputDecoration(
                        labelText: 'Nom du compteur',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _onCounterNameChanged,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _goal?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Objectif',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: _onGoalChanged,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _toggleEditingCounterName,
                      child: const Text('Valider'),
                    ),
                  ],
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
            if (_isEditingCounterName == false && _goal != null && _goal! > 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: (_counter / _goal!).clamp(0.0, 1.0),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_counter / $_goal',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: .center,
              children: [
                IconButton.outlined(
                  onPressed: _decrementCounter,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  icon: const Icon(Icons.remove, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _incrementCounter,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 28),
                    label: const Text(
                      "Augmenter le compteur de 1 parce que c'est top",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
