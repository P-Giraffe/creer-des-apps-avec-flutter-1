import 'package:go_router/go_router.dart';

import '../models/counter_service.dart';
import '../models/local_ai_service.dart';
import 'counter_screen.dart';
import 'welcome_screen.dart';

// `localAiService` est injecté ici dès maintenant pour être prêt à l'emploi par
// le futur écran d'IA locale ; il n'est pas encore rattaché à une route.
GoRouter createRouter(
  CounterService counterService,
  LocalAiService localAiService,
) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => WelcomeScreen(service: counterService),
      ),
      GoRoute(
        path: '/counter/:id',
        builder: (context, state) => CounterScreen(
          service: counterService,
          counterId: int.parse(state.pathParameters['id']!),
        ),
      ),
    ],
  );
}
