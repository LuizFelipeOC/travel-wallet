import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_wallet/app/core/constants/app_images.dart';

import '../../../l10n/app_localizations.dart';

import '../../core/extends/extends.dart';
import '../../core/routes/routes.dart';
import '../../core/widgtes/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final emptyList = [];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = context.width;
    final double screenHeight = context.height;

    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSilverHomeBar(),
            if (emptyList.isEmpty) ...[
              SliverFillRemaining(
                hasScrollBody: false,
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
                        onPressed: () => context.push(AppRoutes.travelerPlannerForm),
                        title: localizations.home_create_new_travel,
                        isOutlined: true,
                        width: screenWidth * 0.8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
