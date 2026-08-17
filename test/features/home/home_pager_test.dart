import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/di/di.dart';
import 'package:travel_wallet/app/features/home/home_screen.dart';
import 'package:travel_wallet/app/features/home/state/home_controller.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/state/traveler_planner_form_controller.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

class MockCreateFormRepository extends Mock implements CreateFormRepository {}

class FakeCreateFormRequestModel extends Fake implements CreateFormRequestModel {}

void main() {
  late MockCreateFormRepository repository;
  late TravelerPlannerFormController formController;

  setUpAll(() => registerFallbackValue(FakeCreateFormRequestModel()));

  setUp(() async {
    repository = MockCreateFormRepository();
    formController = TravelerPlannerFormController(createFormRepository: repository);

    await getIt.reset();
    getIt.registerLazySingleton<CreateFormRepository>(() => repository);
    getIt.registerLazySingleton<HomeController>(
      () => HomeController(createFormRepository: repository),
    );
    // Registered as a singleton here so the test can reach the same instance
    // the form widget builds with.
    getIt.registerFactory<TravelerPlannerFormController>(() => formController);
  });

  tearDown(() async => getIt.reset());

  Widget app() => MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: const HomeScreen(),
  );

  testWidgets('loads saved travels from the repository on start', (tester) async {
    when(repository.getTravels).thenAnswer(
      (_) async => Success([
        CreateFormRequestModel(
          id: '1',
          travelName: 'Rio de Janeiro',
          budgetPlan: '2000',
          startDate: DateTime(2026, 7, 26),
          endDate: DateTime(2026, 8, 2),
        ),
      ]),
    );

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Rio de Janeiro'), findsOneWidget);
    expect(find.text('No trips yet'), findsNothing);
  });

  testWidgets('shows the empty state when there is nothing saved', (tester) async {
    when(repository.getTravels).thenAnswer((_) async => const Success(<CreateFormRequestModel>[]));

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('No trips yet'), findsOneWidget);
  });

  testWidgets('tabs page between trips, form and sign in', (tester) async {
    when(repository.getTravels).thenAnswer((_) async => const Success(<CreateFormRequestModel>[]));

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.tap(find.text('New trip'));
    await tester.pumpAndSettle();
    expect(find.text('Planner'), findsOneWidget);

    // swiping works the same as tapping a tab
    await tester.fling(find.text('Planner'), const Offset(600, 0), 1200);
    await tester.pumpAndSettle();
    expect(find.text('No trips yet'), findsOneWidget);
  });

  testWidgets('saving a travel persists it and returns to the trips page', (tester) async {
    when(repository.getTravels).thenAnswer((_) async => const Success(<CreateFormRequestModel>[]));

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('New trip'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Rio de Janeiro');
    await tester.enterText(find.byType(TextFormField).at(1), '2000');
    formController.setTravelPeriod(
      DateTimeRange(start: DateTime(2026, 7, 26), end: DateTime(2026, 8, 2)),
    );
    await tester.pump();

    final saved = CreateFormRequestModel(
      id: '1',
      travelName: 'Rio de Janeiro',
      budgetPlan: '2000',
      startDate: DateTime(2026, 7, 26),
      endDate: DateTime(2026, 8, 2),
    );

    when(
      () => repository.createTravel(formRequest: any(named: 'formRequest')),
    ).thenAnswer((_) async => Success(saved));
    when(repository.getTravels).thenAnswer((_) async => Success([saved]));

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final request =
        verify(
              () => repository.createTravel(formRequest: captureAny(named: 'formRequest')),
            ).captured.single
            as CreateFormRequestModel;

    expect(request.travelName, 'Rio de Janeiro');
    expect(request.budgetPlan, '2000');
    expect(request.startDate, DateTime(2026, 7, 26));
    expect(request.endDate, DateTime(2026, 8, 2));

    // back on the trips page, with the new travel listed
    expect(find.text('Rio de Janeiro'), findsOneWidget);
  });

  testWidgets('does not save without a travel period', (tester) async {
    when(repository.getTravels).thenAnswer((_) async => const Success(<CreateFormRequestModel>[]));

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('New trip'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Rio de Janeiro');
    await tester.enterText(find.byType(TextFormField).at(1), '2000');

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    verifyNever(() => repository.createTravel(formRequest: any(named: 'formRequest')));
  });
}
