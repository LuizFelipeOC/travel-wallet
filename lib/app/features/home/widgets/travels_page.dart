import 'package:flutter/material.dart';

import '../../../core/widgtes/app_bar/custom_silver_home_bar.dart';
import '../state/home_controller.dart';
import '../state/home_state.dart';
import 'travel_list.dart';
import 'travels_empty_state.dart';
import 'travels_message.dart';

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
                  child: TravelsMessage(text: message, bottomInset: bottomInset),
                ),
                HomeLoaded() => TravelsEmptyState(
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
