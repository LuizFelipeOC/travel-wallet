import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/widgets/traveler_form.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extends/extends.dart';
import '../../../core/widgtes/app_bar/custom_silver_app_bar.dart';
import '../../../routers/app_routes.dart';

class TravelerPlannerFormScreen extends StatefulWidget {
  final bool isFirstTimeUser;

  /// Set when the form is hosted inside the home pager instead of being pushed
  /// as its own route: the back button is dropped and saving is reported to the
  /// host through [onSaved].
  final bool isEmbedded;
  final VoidCallback? onSaved;

  const TravelerPlannerFormScreen({
    super.key,
    this.isFirstTimeUser = false,
    this.isEmbedded = false,
    this.onSaved,
  });

  @override
  State<TravelerPlannerFormScreen> createState() => _TravelerPlannerFormScreenState();
}

class _TravelerPlannerFormScreenState extends State<TravelerPlannerFormScreen> {
  void _onSaved() {
    if (widget.onSaved != null) {
      widget.onSaved!();
      return;
    }

    if (widget.isFirstTimeUser) {
      context.go(AppRoutes.home);
      return;
    }

    context.popOrGo(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;

    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: widget.isEmbedded ? Colors.transparent : null,
      body: CustomScrollView(
        slivers: [
          CustomSilverAppBar(
            hasBackButton: !widget.isFirstTimeUser && !widget.isEmbedded,
            screenHeight: screenHeight,
            title: localizations.travler_form_title,
            subtitle: localizations.travler_form_subtitle,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  TravelerForm(onSaved: _onSaved),
                ],
              ),
            ),
          ),

          if (widget.isFirstTimeUser) ...[
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
        ],
      ),
    );
  }
}
