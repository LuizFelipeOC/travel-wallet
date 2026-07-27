import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/erros/traveler_planner_form_erros.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/state/traveler_planner_form_controller.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/state/traveler_planner_form_state.dart';

class MockCreateFormRepository extends Mock implements CreateFormRepository {}

void main() {
  group('TravelerPlannerFormController', () {
    late MockCreateFormRepository repository;
    late TravelerPlannerFormController controller;

    setUp(() {
      repository = MockCreateFormRepository();
      controller = TravelerPlannerFormController(createFormRepository: repository);
    });

    test('starts on initial state', () {
      expect(controller.value, isA<TravelerPlannerFormInitial>());
    });

    test('emits loading and success when submission succeeds', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      when(
        () => repository.createTravel(formRequest: request),
      ).thenAnswer((_) async => Success(request));

      final states = <ITravelerPlannerFormState>[];
      controller.addListener(() {
        states.add(controller.value);
      });

      await controller.submitForm(request);

      expect(states, hasLength(2));
      expect(states[0], isA<TravelerPlannerFormLoading>());
      expect(states[1], isA<TravelerPlannerFormSuccess>());
      verify(() => repository.createTravel(formRequest: request)).called(1);
    });

    test('emits loading and error when submission fails', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      when(() => repository.createTravel(formRequest: request)).thenAnswer(
        (_) async => Failure(TravelerFormSubmissionError(message: 'An unexpected error occurred.')),
      );

      final states = <ITravelerPlannerFormState>[];
      controller.addListener(() {
        states.add(controller.value);
      });

      await controller.submitForm(request);

      expect(states, hasLength(2));
      expect(states[0], isA<TravelerPlannerFormLoading>());
      expect(states[1], isA<TravelerPlannerFormError>());
      expect((states[1] as TravelerPlannerFormError).message, 'An unexpected error occurred.');
      verify(() => repository.createTravel(formRequest: request)).called(1);
    });
  });
}
