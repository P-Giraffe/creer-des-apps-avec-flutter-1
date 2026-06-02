import 'package:go_router/go_router.dart';

import '../models/counter_service.dart';
import 'counter_screen.dart';
import 'welcome_screen.dart';

GoRouter createRouter(CounterService service) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/counter',
        builder: (context, state) => CounterScreen(service: service),
      ),
    ],
  );
}
