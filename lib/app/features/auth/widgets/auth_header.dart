import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/extends/extends.dart';
import '../../../core/widgtes/app_svg/app_svg.dart';
import '../../../core/widgtes/fade_in/fade_in.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  const AuthHeader({super.key, required this.title, required this.subtitle, this.onBack});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double screenHeight = context.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: onBack == null
              ? null
              : Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
                ),
        ),
        FadeIn(
          child: Center(
            child: AppSvg(
              assetName: Appimages.planet,
              assetsType: AssetsType.asset,
              height: screenHeight * 0.16,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        FadeIn(
          delay: const Duration(milliseconds: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(subtitle, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
