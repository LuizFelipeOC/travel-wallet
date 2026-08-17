import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/extends/extends.dart';
import '../../../core/widgtes/app_bar/custom_silver_home_bar.dart';
import '../../../core/widgtes/app_svg/app_svg.dart';
import '../../../core/widgtes/custom_buttons/cusom_button.dart';
import '../state/home_controller.dart';
import '../state/home_state.dart';
import 'travel_list.dart';

class TravelsPage extends StatelessWidget {
  final HomeController controller;
  final VoidCallback onCreateTravel;
  final double bottomInset;

  const TravelsPage({
    super.key,
    required this.controller,
    required this.onCreateTravel,
    required this.bottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IHomeState>(
      valueListenable: controller,
      builder: (context, state, _) {
        return RefreshIndicator(
          onRefresh: controller.loadTravels,
          child: CustomScrollView(
            slivers: [
              CustomSilverHomeBar(),
              switch (state) {
                HomeLoaded(isEmpty: false, travels: final travels) => TravelList(
                  travels: travels,
                  padding: EdgeInsets.fromLTRB(16, 8, 16, bottomInset),
                ),
                HomeError(message: final message) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: _Message(text: message, bottomInset: bottomInset),
                ),
                HomeLoaded() => _EmptyState(
                  onCreateTravel: onCreateTravel,
                  bottomInset: bottomInset,
                ),
                _ => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                ),
              },
            ],
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreateTravel;
  final double bottomInset;

  const _EmptyState({required this.onCreateTravel, required this.bottomInset});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final double screenWidth = context.width;
    final double screenHeight = context.height;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSvg(
                assetName: Appimages.planet,
                width: screenWidth * 0.4,
                height: screenHeight * 0.20,
                assetsType: AssetsType.asset,
              ),
              const SizedBox(height: 26),
              Text(localizations.home_empty_list_title),
              const SizedBox(height: 26),
              CustomButton(
                onPressed: onCreateTravel,
                title: localizations.home_create_new_travel,
                isOutlined: true,
                width: screenWidth * 0.8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  final double bottomInset;

  const _Message({required this.text, required this.bottomInset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset, left: 24, right: 24),
      child: Center(child: Text(text, textAlign: TextAlign.center)),
    );
  }
}
