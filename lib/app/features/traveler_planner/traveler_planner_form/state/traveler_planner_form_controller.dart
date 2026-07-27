import 'package:flutter/material.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/state/traveler_planner_form_state.dart';

import '../data/models/create_form_request.dart';
import '../data/repositories/create_form_repository.dart';
import '../data/erros/traveler_planner_form_erros.dart';
import 'traveler_planner_form_validator.dart';

class TravelerPlannerFormController extends ValueNotifier<ITravelerPlannerFormState>
    with TravelerPlannerFormValidator {
  final CreateFormRepository createFormRepository;
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  TravelerPlannerFormController({required this.createFormRepository})
    : super(TravelerPlannerFormInitial());

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      formKey.currentState?.save();
    }

    return isValid;
  }

  Future<void> saveTravelerForm() async {
    if (!validateForm()) {
      return;
    }

    final request = CreateFormRequestModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      travelName: nameController.text.trim(),
      budgetPlan: budgetController.text.trim(),
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
    );

    await submitForm(request);
  }

  Future<void> submitForm(CreateFormRequestModel formRequest) async {
    setState(state: TravelerPlannerFormLoading());

    final result = await createFormRepository.createTravel(formRequest: formRequest);

    switch (result) {
      case Success(data: _):
        setState(state: TravelerPlannerFormSuccess());
        return;
      case Failure(error: final error):
        if (error is ITravelerPlannerFormErros) {
          setState(state: TravelerPlannerFormError(message: error.message));
          return;
        }

        setState(state: TravelerPlannerFormError(message: 'Unexpected error'));
        return;
      default:
        setState(state: TravelerPlannerFormError(message: 'Unexpected error'));
        return;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void setState({required ITravelerPlannerFormState state}) {
    value = state;
  }
}
