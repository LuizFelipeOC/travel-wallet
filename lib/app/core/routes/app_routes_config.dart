import 'package:go_router/go_router.dart';
import 'package:travel_wallet/app/screens/screens.dart';

import 'routes.dart';

final GoRouter appRouterConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnboardingScreen()),
  ],
);
