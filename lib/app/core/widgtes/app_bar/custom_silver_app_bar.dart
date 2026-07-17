import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomSilverAppBar extends StatelessWidget {
  final double screenHeight;
  final String title;

  final String? subtitle;

  const CustomSilverAppBar({
    super.key,
    required this.screenHeight,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.16,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.loose,
          children: [
            Container(decoration: BoxDecoration(gradient: AppColors.primaryGradient)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    if (subtitle != null) ...[
                      SizedBox(height: 6),
                      Text(
                        subtitle!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -1,
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
