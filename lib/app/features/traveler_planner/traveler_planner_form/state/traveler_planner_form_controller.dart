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
  final TextEditingController periodController = TextEditingController();

  DateTimeRange? travelPeriod;

  /// Id of the travel being edited, or `null` when creating a new one.
  String? editingId;

  bool get isEditing => editingId != null;

  TravelerPlannerFormController({required this.createFormRepository})
    : super(TravelerPlannerFormInitial());

  /// Prefills the form with an existing travel so it can be edited.
  void startEditing(CreateFormRequestModel travel) {
    editingId = travel.id;
    nameController.text = travel.travelName;
    budgetController.text = travel.budgetPlan;
    setTravelPeriod(DateTimeRange(start: travel.startDate, end: travel.endDate));
    setState(state: TravelerPlannerFormInitial());
  }

  void setTravelPeriod(DateTimeRange range) {
    travelPeriod = range;
    periodController.text = '${_formatDate(range.start)} - ${_formatDate(range.end)}';
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

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

    final period = travelPeriod;

    if (period == null) {
      setState(state: TravelerPlannerFormError(message: 'Select the travel period'));
      return;
    }

    final request = CreateFormRequestModel(
      id: editingId ?? DateTime.now().microsecondsSinceEpoch.toString(),
      travelName: nameController.text.trim(),
      budgetPlan: budgetController.text.trim(),
      startDate: period.start,
      endDate: period.end,
    );

    await submitForm(request);
  }

  void clearForm() {
    nameController.clear();
    budgetController.clear();
    periodController.clear();
    travelPeriod = null;
    editingId = null;
    formKey.currentState?.reset();
    setState(state: TravelerPlannerFormInitial());
  }

  Future<void> submitForm(CreateFormRequestModel formRequest) async {
    setState(state: TravelerPlannerFormLoading());

    final result = isEditing
        ? await createFormRepository.updateTravel(formRequest: formRequest)
        : await createFormRepository.createTravel(formRequest: formRequest);

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
    periodController.dispose();
    super.dispose();
  }

  void setState({required ITravelerPlannerFormState state}) {
    value = state;
  }
}
