import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_wallet/app/core/widgtes/widgets.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

import '../../../core/constants/constants.dart';
import '../../../di/di.dart';
import '../../../core/extends/extends.dart';
import '../../../routers/app_routes.dart';
import '../state/onboarding_controller.dart';
import '../state/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = getIt.get<OnboardingController>();

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkHasFirstTimeUser();

      controller.addListener(() {
        final state = controller.value;

        if (state is OnboardingHasFirstTimeUser && mounted && state.hasFirstTimeUser) {
          context.go(AppRoutes.home);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height;
    final double screenWidth = context.width;

    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                FadeIn(
                  delay: const Duration(milliseconds: 750),
                  child: AppSvg(
                    assetName: Appimages.travelers,
                    assetsType: AssetsType.asset,
                    height: screenHeight * 0.26,
                    width: screenWidth * 0.26,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, state, _) {
                    if (state is OnboardingLoading) {
                      return const CircularProgressIndicator();
                    }

                    if (state is OnboardingHasFirstTimeUser) {
                      if (!state.hasFirstTimeUser) {
                        return FadeIn(
                          delay: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: .only(left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: .center,
                              mainAxisAlignment: .center,
                              children: [
                                Text(
                                  localizations.onboardingTitle,
                                  style: textTheme.headlineSmall,
                                  textAlign: .center,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  localizations.onboardingDescription,
                                  textAlign: .center,
                                  style: textTheme.bodyMedium,
                                ),

                                SizedBox(height: screenHeight * 0.08),
                                FadeIn(
                                  delay: const Duration(milliseconds: 900),
                                  child: Padding(
                                    padding: .only(left: 12, right: 12),
                                    child: CustomButton(
                                      title: localizations.getStarted,
                                      onPressed: () {
                                        controller.setFirstTimeUser();
                                        context.go(
                                          AppRoutes.travelerPlannerForm,
                                          extra: {'isFirstTimeUser': true},
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
