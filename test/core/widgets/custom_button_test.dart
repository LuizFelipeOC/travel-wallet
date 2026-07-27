import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_wallet/app/core/widgtes/custom_buttons/cusom_button.dart';

void main() {
  testWidgets('shows loading animation when isLoading is true', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(title: 'Salvar', isLoading: true, onPressed: () {}),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 250));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Salvar'), findsOneWidget);
  });
}
