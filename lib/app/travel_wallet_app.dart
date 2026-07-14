import 'package:flutter/material.dart';

import 'core/routes/routes.dart';

class TravelWalletApp extends StatefulWidget {
  const TravelWalletApp({super.key});

  @override
  State<TravelWalletApp> createState() => _TravelWalletAppState();
}

class _TravelWalletAppState extends State<TravelWalletApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouterConfig, debugShowCheckedModeBanner: false);
  }
}
