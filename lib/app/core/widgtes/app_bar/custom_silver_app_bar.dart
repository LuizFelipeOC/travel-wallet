import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            Text(title, style: textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
