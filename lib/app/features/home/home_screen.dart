import 'package:flutter/material.dart';

import '../../core/widgtes/bottom_navigator/liquid_glass_bottom_bar.dart';
import '../../di/di.dart';
import '../../../l10n/app_localizations.dart';
import '../auth/presentation/sign_in_screen.dart';
import '../traveler_planner/traveler_planner_form/traveler_planner_form_screen.dart';
import 'state/home_controller.dart';
import 'widgets/travels_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = getIt.get<HomeController>();
  final _pageController = PageController();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    controller.loadTravels();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _onTravelSaved() {
    controller.loadTravels();
    _goToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Leaves room for the floating glass bar at the end of every page.
    final double bottomInset = 96 + MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: LiquidGlassBottomBar(
        currentIndex: _currentIndex,
        onTap: _goToPage,
        items: [
          LiquidGlassNavItem(
            icon: Icons.card_travel_outlined,
            selectedIcon: Icons.card_travel,
            label: localizations.nav_trips,
          ),
          LiquidGlassNavItem(
            icon: Icons.add_circle_outline,
            selectedIcon: Icons.add_circle,
            label: localizations.nav_new_trip,
          ),
          LiquidGlassNavItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: localizations.nav_account,
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: [
            TravelsPage(
              controller: controller,
              onCreateTravel: () => _goToPage(1),
              bottomInset: bottomInset,
            ),
            TravelerPlannerFormScreen(isEmbedded: true, onSaved: _onTravelSaved),
            SignInScreen(isEmbedded: true, bottomInset: bottomInset),
          ],
        ),
      ),
    );
  }
}
