import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

import 'core/routes/routes.dart';
import 'core/themes/themes.dart';

class TravelWalletApp extends StatefulWidget {
  const TravelWalletApp({super.key});

  @override
  State<TravelWalletApp> createState() => _TravelWalletAppState();
}

class _TravelWalletAppState extends State<TravelWalletApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouterConfig,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
    );
  }
}
