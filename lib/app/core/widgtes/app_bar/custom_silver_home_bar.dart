import 'package:flutter/material.dart';
import 'package:travel_wallet/app/core/constants/app_images.dart';
import 'package:travel_wallet/app/core/widgtes/app_svg/app_svg.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

import '../../extends/extends.dart';

class CustomSilverHomeBar extends StatefulWidget {
  const CustomSilverHomeBar({super.key});

  @override
  State<CustomSilverHomeBar> createState() => _CustomSilverHomeBarState();
}

class _CustomSilverHomeBarState extends State<CustomSilverHomeBar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double screenHeight = context.height;
    final double screenWidth = context.width;

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: screenHeight * 0.1,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: .only(left: 12, right: 12, bottom: 12),
        title: Row(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            Row(
              crossAxisAlignment: .center,
              children: [
                AppSvg(
                  assetName: Appimages.planet,
                  assetsType: AssetsType.asset,
                  height: screenHeight * 0.030,
                  width: screenWidth * 0.06,
                ),
                SizedBox(width: screenWidth * 0.016),
                Text(
                  AppLocalizations.of(context)!.home_app_title,
                  style: textTheme.headlineSmall?.copyWith(
                    color: Colors.amber,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
