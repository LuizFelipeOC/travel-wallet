import 'package:go_router/go_router.dart';
import 'package:travel_wallet/app/screens/home/home_screen.dart';
import 'package:travel_wallet/app/screens/screens.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

final GoRouter appRouterConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) =>
          _fadeSlidePage(key: state.pageKey, child: const OnboardingScreen()),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          _fadeSlidePage(key: state.pageKey, child: const HomeScreen()),
    ),
  ],
);

CustomTransitionPage<void> _fadeSlidePage({required LocalKey key, required Widget child}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Animation<double> curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      final Animation<Offset> offsetAnimation = Tween<Offset>(
        begin: const Offset(0.02, 0.03),
        end: Offset.zero,
      ).animate(curvedAnimation);

      return FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(position: offsetAnimation, child: child),
      );
    },
  );
}
