import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_wallet/app/screens/traveler_planner/traveler_planner_form/widgets/traveler_form.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extends/extends.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgtes/widgets.dart';

class TravelerPlannerFormScreen extends StatefulWidget {
  const TravelerPlannerFormScreen({super.key});

  @override
  State<TravelerPlannerFormScreen> createState() => _TravelerPlannerFormScreenState();
}

class _TravelerPlannerFormScreenState extends State<TravelerPlannerFormScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;

    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSilverAppBar(
            screenHeight: screenHeight,
            title: localizations.travler_form_title,
            subtitle: localizations.travler_form_subtitle,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(children: [const SizedBox(height: 8), TravelerForm()]),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                  child: Text(localizations.travler_form_create_before),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
