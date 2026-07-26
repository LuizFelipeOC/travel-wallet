import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import '../erros/traveler_planner_form_erros.dart';

class CreateFormRepository {
  Future<Result<CreateFormRequestModel>> createTravel({
    required CreateFormRequestModel formRequest,
  }) async {
    if (formRequest.budgetPlan.isEmpty || formRequest.travelName.isEmpty) {
      return Failure(
        TravelerFormValidationError(message: 'Travel name and budget plan cannot be empty.'),
      );
    }

    if (formRequest.startDate.isAfter(formRequest.endDate)) {
      return Failure(TravelerFormValidationError(message: 'Start date cannot be after end date.'));
    }

    try {
      return Success(formRequest);
    } catch (e) {
      return Failure(TravelerFormSubmissionError(message: 'An unexpected error occurred.'));
    }
  }
}
