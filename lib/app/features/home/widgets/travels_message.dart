import 'package:flutter/material.dart';

class TravelsMessage extends StatelessWidget {
  final String text;
  final double bottomInset;

  const TravelsMessage({super.key, required this.text, required this.bottomInset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset, left: 24, right: 24),
      child: Center(child: Text(text, textAlign: TextAlign.center)),
    );
  }
}
