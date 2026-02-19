import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes Petits Totaux',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
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

  bool get _isGoalReached => _goal != null && _goal! > 0 && _counter >= _goal!;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final successColor = Colors.green.shade600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.1),
              colorScheme.secondary.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _isEditingCounterName
                    ? _buildEditingView(context)
                    : _buildCounterView(context, successColor),
              ),
              if (_isEditingCounterName == false) _buildControlButtons(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.tag, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes Petits Totaux',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [colorScheme.primary, colorScheme.secondary],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 40)),
                  ),
                ),
                Text(
                  'Comptez vos objectifs',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditingView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.edit_note, color: colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Configurer le compteur',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              initialValue: _counterName,
              decoration: InputDecoration(
                labelText: 'Nom du compteur',
                hintText: 'Ex: Pompes, Verres d\'eau...',
                prefixIcon: const Icon(Icons.label_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              onChanged: _onCounterNameChanged,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _goal?.toString(),
              decoration: InputDecoration(
                labelText: 'Objectif',
                hintText: 'Nombre à atteindre',
                prefixIcon: const Icon(Icons.flag_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: _onGoalChanged,
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _toggleEditingCounterName,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.check),
              label: const Text(
                'Valider',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterView(BuildContext context, Color successColor) {
    final colorScheme = Theme.of(context).colorScheme;
    final displayColor = _isGoalReached ? successColor : colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_counterName.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isGoalReached)
                  Icon(Icons.check_circle, color: successColor, size: 24),
                if (_isGoalReached) const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _counterName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: _isGoalReached
                          ? successColor
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          GestureDetector(
            onTap: _toggleEditingCounterName,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    'Modifier',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isGoalReached
                    ? [
                        successColor.withValues(alpha: 0.1),
                        successColor.withValues(alpha: 0.2),
                      ]
                    : [
                        colorScheme.primary.withValues(alpha: 0.1),
                        colorScheme.secondary.withValues(alpha: 0.15),
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: displayColor.withValues(alpha: 0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: _isGoalReached
                          ? [successColor, successColor.withValues(alpha: 0.8)]
                          : [colorScheme.primary, colorScheme.secondary],
                    ).createShader(const Rect.fromLTWH(0, 0, 150, 80)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_counter > 10)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.orange.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ca commence a faire du bruit !',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
          if (_goal != null && _goal! > 0)
            _buildProgressSection(context, successColor),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, Color successColor) {
    final colorScheme = Theme.of(context).colorScheme;
    final progress = (_counter / _goal!).clamp(0.0, 1.0);
    final progressColor = _isGoalReached ? successColor : colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    _isGoalReached ? Icons.emoji_events : Icons.flag,
                    color: progressColor,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isGoalReached ? 'Objectif atteint !' : 'Progression',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: progressColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: progressColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_counter / $_goal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildControlButton(
            onPressed: _decrementCounter,
            icon: Icons.remove,
            backgroundColor: Colors.white,
            iconColor: colorScheme.primary,
            borderColor: colorScheme.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 40),
          _buildControlButton(
            onPressed: _incrementCounter,
            icon: Icons.add,
            backgroundColor: colorScheme.primary,
            iconColor: Colors.white,
            isLarge: true,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    Color? borderColor,
    bool isLarge = false,
  }) {
    final size = isLarge ? 80.0 : 64.0;
    final iconSize = isLarge ? 36.0 : 28.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: borderColor != null
                ? Border.all(color: borderColor, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: backgroundColor == Colors.white
                    ? Colors.grey.shade300
                    : backgroundColor.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
