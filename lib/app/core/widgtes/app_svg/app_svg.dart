import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AssetsType { network, asset }

class AppSvg extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final AssetsType assetsType;

  const AppSvg({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    required this.assetsType,
  });

  @override
  Widget build(BuildContext context) {
    if (assetsType == AssetsType.network) {
      return SvgPicture.network(assetName, width: width, height: height);
    }

    return SvgPicture.asset(assetName, width: width, height: height);
  }
}
