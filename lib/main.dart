import 'package:flutter/material.dart';
import 'package:travel_wallet/app/travel_wallet_app.dart';

import 'app/core/di/di.dart';

void main() {
  setupDependencies();

  runApp(const TravelWalletApp());
}
