import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/counter.dart';
import '../models/counter_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.service});

  final CounterService service;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Counter> _counters = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCounters();
  }

  void _loadCounters() async {
    final counters = await widget.service.loadCounters();
    if (mounted) {
      setState(() {
        _counters = counters;
        _isLoading = false;
      });
    }
  }

  void _openCounter(int id) async {
    await context.push('/counter/$id');
    if (mounted) {
      _loadCounters();
    }
  }

  void _createCounter() async {
    final created = await widget.service.createCounter();
    if (mounted) {
      await context.push('/counter/${created.id}');
      if (mounted) {
        _loadCounters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Text(
        'Mes petits totaux,\ncomptez vos objectifs',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
            ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget content;
    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (_counters.isEmpty) {
      content = _buildEmptyState(context);
    } else {
      content = _buildCounterList(context);
    }
    return content;
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 72, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Aucun compteur pour l\'instant',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Créez votre premier compteur pour commencer.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 32),
          _buildCreateButton(context),
        ],
      ),
    );
  }

  Widget _buildCounterList(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            itemCount: _counters.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _buildCounterTile(context, _counters[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: _buildCreateButton(context),
        ),
      ],
    );
  }

  Widget _buildCounterTile(BuildContext context, Counter counter) {
    final colorScheme = Theme.of(context).colorScheme;
    final successColor = Colors.green.shade600;
    final accentColor = counter.isGoalReached
        ? successColor
        : colorScheme.primary;
    final hasGoal = counter.goal != null && counter.goal! > 0;
    final name = counter.name.isEmpty ? 'Compteur sans nom' : counter.name;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openCounter(counter.id!),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (counter.isGoalReached) ...[
                    Icon(Icons.check_circle, color: successColor, size: 22),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: counter.name.isEmpty
                            ? Colors.grey.shade500
                            : Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      '${counter.value}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
              if (hasGoal) ...[
                const SizedBox(height: 16),
                _buildTileProgress(context, counter, accentColor),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTileProgress(
    BuildContext context,
    Counter counter,
    Color accentColor,
  ) {
    final progress = (counter.value / counter.goal!).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${counter.value} / ${counter.goal}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: _createCounter,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      icon: const Icon(Icons.add),
      label: const Text(
        'Nouveau compteur',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
