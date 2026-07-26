// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'traveler_planner_form_validator.dart';

abstract interface class ITravelerPlannerFormState {}

class TravelerPlannerFormInitial implements ITravelerPlannerFormState {}

class TravelerPlannerFormLoading implements ITravelerPlannerFormState {}

class TravelerPlannerFormError implements ITravelerPlannerFormState {
  final String message;

  TravelerPlannerFormError({required this.message});
}

class TravelerPlannerFormSuccess implements ITravelerPlannerFormState {}

class TravelerPlannerFormController with TravelerPlannerFormValidator {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (isValid) {
      formKey.currentState?.save();
    }

    return isValid;
  }

  Future<void> saveTravelerForm() async {
    validateForm();
  }

  void dispose() {
    nameController.dispose();
    budgetController.dispose();
  }
}
