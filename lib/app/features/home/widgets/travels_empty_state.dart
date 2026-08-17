import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/extends/extends.dart';
import '../../../core/widgtes/app_svg/app_svg.dart';
import '../../../core/widgtes/custom_buttons/cusom_button.dart';

class TravelsEmptyState extends StatelessWidget {
  final VoidCallback onCreateTravel;
  final double bottomInset;

  const TravelsEmptyState({super.key, required this.onCreateTravel, required this.bottomInset});

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
