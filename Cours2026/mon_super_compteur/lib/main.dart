import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_source/counter_database_data_source.dart';
import 'models/counter_service.dart';
import 'ui/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, GoRouter? router})
    : _router =
          router ?? createRouter(CounterService(CounterDatabaseDataSource()));

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}
