import 'package:flutter_test/flutter_test.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/erros/traveler_planner_form_erros.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';

void main() {
  group('CreateFormRepository', () {
    late CreateFormRepository repository;

    setUp(() {
      repository = CreateFormRepository();
    });

    test('returns validation failure when travel name or budget is empty', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: '',
        budgetPlan: '',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      final result = await repository.createTravel(formRequest: request);

      expect(result, isA<Failure<CreateFormRequestModel, TravelerFormValidationError>>());

      final failure = result as Failure<CreateFormRequestModel, TravelerFormValidationError>;
      expect(
        failure.error,
        isA<TravelerFormValidationError>().having(
          (error) => error.message,
          'message',
          'Travel name and budget plan cannot be empty.',
        ),
      );
    });

    test('returns validation failure when start date is after end date', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 28),
        endDate: DateTime(2026, 7, 27),
      );

      final result = await repository.createTravel(formRequest: request);

      expect(result, isA<Failure<CreateFormRequestModel, TravelerFormValidationError>>());

      final failure = result as Failure<CreateFormRequestModel, TravelerFormValidationError>;
      expect(
        failure.error,
        isA<TravelerFormValidationError>().having(
          (error) => error.message,
          'message',
          'Start date cannot be after end date.',
        ),
      );
    });

    test('returns success when request is valid', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      final result = await repository.createTravel(formRequest: request);

      expect(result, isA<Success<CreateFormRequestModel>>());
      expect((result as Success<CreateFormRequestModel>).data, same(request));
    });
  });
}
