import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSilverAppBar extends StatelessWidget {
  final double screenHeight;
  final String title;
  final bool hasBackButton;

  final String? subtitle;

  const CustomSilverAppBar({
    super.key,
    required this.screenHeight,
    required this.title,
    this.subtitle,
    this.hasBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      pinned: false,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: screenHeight * 0.10,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasBackButton) ...[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
            ],

            Padding(
              padding: EdgeInsets.only(left: hasBackButton ? 0 : 12, right: 12),
              child: Text(title, style: textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
