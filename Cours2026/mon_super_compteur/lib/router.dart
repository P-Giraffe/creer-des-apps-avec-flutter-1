import 'package:go_router/go_router.dart';

import 'counter_screen.dart';
import 'welcome_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/counter',
        builder: (context, state) => const CounterScreen(),
      ),
    ],
  );
}
