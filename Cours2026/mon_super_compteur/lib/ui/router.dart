import 'package:go_router/go_router.dart';

import '../models/counter_service.dart';
import 'counter_screen.dart';
import 'welcome_screen.dart';

GoRouter createRouter(CounterService service) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => WelcomeScreen(service: service),
      ),
      GoRoute(
        path: '/counter/:id',
        builder: (context, state) => CounterScreen(
          service: service,
          counterId: int.parse(state.pathParameters['id']!),
        ),
      ),
    ],
  );
}
