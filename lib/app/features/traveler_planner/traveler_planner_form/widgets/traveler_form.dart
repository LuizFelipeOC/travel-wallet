import 'package:flutter/material.dart';

import '../../../../core/widgtes/custom_buttons/cusom_button.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../di/di.dart';
import '../state/traveler_planner_form_controller.dart';
import '../state/traveler_planner_form_state.dart';

class TravelerForm extends StatefulWidget {
  const TravelerForm({super.key});

  @override
  State<TravelerForm> createState() => _TravelerFormState();
}

class _TravelerFormState extends State<TravelerForm> {
  final controller = getIt.get<TravelerPlannerFormController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: controller.formKey,
      child: ValueListenableBuilder<ITravelerPlannerFormState>(
        valueListenable: controller,
        builder: (context, state, _) {
          final isLoading = state is TravelerPlannerFormLoading;
          final errorMessage = state is TravelerPlannerFormError ? state.message : null;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: controller.nameController,
                decoration: InputDecoration(labelText: l10n.travler_form_name),
                validator: (value) => controller.requiredText(value, l10n.travler_form_name),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: controller.budgetController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: l10n.travler_form_budget),
                validator: (value) => controller.requiredCurrency(value, l10n.travler_form_budget),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: InputDecorator(
                  decoration: InputDecoration(labelText: l10n.travler_form_roundtrip),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(l10n.travler_form_roundtrip, style: textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: errorMessage == null
                    ? const SizedBox.shrink()
                    : Padding(
                        key: ValueKey(errorMessage),
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          errorMessage,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();

                              controller.saveTravelerForm();
                            },
                      isLoading: isLoading,
                      title: l10n.travler_form_save,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
