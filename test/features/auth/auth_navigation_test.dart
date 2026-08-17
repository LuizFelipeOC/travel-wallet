import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_wallet/app/routers/app_router.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

Widget app() => MaterialApp.router(
  routerConfig: appRouterConfig,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
);

void main() {
  testWidgets('recovery: back on step 2 returns to step 1, not out of the screen', (tester) async {
    appRouterConfig.go('/recovery-password');
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'a@b.com');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Recovering the account a@b.com'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // back to step 1 with the typed email preserved
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('a@b.com'), findsOneWidget);

    // second back leaves the screen without a GoError
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('recovery: reset shows feedback and returns to sign in', (tester) async {
    appRouterConfig.go('/recovery-password');
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'a@b.com');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'secret123');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
    await tester.tap(find.text('Save new password'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Password updated'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('home: account tab opens sign in, which can be dismissed', (tester) async {
    appRouterConfig.go('/home');
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.ensureVisible(find.text('Continue without an account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue without an account'));
    await tester.pumpAndSettle();
    expect(find.text('No trips yet'), findsOneWidget);
  });

  testWidgets('sign up: back returns to sign in', (tester) async {
    appRouterConfig.go('/sign-in');
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();
    expect(find.text('Create your account'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
