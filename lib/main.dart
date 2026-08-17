import 'package:flutter/material.dart';
import 'package:travel_wallet/app/travel_wallet_app.dart';

import 'app/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(const TravelWalletApp());
}
