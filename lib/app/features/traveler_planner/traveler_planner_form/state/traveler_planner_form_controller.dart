import 'package:flutter/material.dart';

import 'traveler_planner_form_validator.dart';

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

  Future<void> saveTravelerForm(BuildContext context) async {
    validateForm();
  }

  void dispose() {
    nameController.dispose();
    budgetController.dispose();
  }
}
