import 'package:flutter/material.dart';
import 'package:travel_wallet/app/core/widgtes/widgets.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

import '../../core/constants/constants.dart';
import '../../core/extends/extends.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;
    final double screenWidth = context.width;

    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Center(
            child: Column(
              children: [
                AppSvg(
                  assetName: Appimages.travelers,
                  assetsType: AssetsType.asset,
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.2,
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      localizations.onboardingTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: .center,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      localizations.onboardingDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: .center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
