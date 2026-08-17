import 'package:flutter/material.dart';

import '../../../../core/widgtes/custom_buttons/cusom_button.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../di/di.dart';
import '../state/traveler_planner_form_controller.dart';
import '../state/traveler_planner_form_state.dart';

class TravelerForm extends StatefulWidget {
  /// Called after the travel is persisted, so the host screen can refresh its
  /// list or leave the form.
  final VoidCallback? onSaved;

  const TravelerForm({super.key, this.onSaved});

  @override
  State<TravelerForm> createState() => _TravelerFormState();
}

class _TravelerFormState extends State<TravelerForm> {
  final controller = getIt.get<TravelerPlannerFormController>();

  @override
  void initState() {
    super.initState();

    controller.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    // The controller is owned by the DI container: the pager disposes and
    // rebuilds this page as it scrolls, and the typed values must survive that.
    controller.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (controller.value is! TravelerPlannerFormSuccess || !mounted) {
      return;
    }

    controller.clearForm();
    widget.onSaved?.call();
  }

  Future<void> _pickPeriod() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      initialDateRange: controller.travelPeriod,
    );

    if (range != null) {
      setState(() => controller.setTravelPeriod(range));
    }
  }

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
              TextFormField(
                controller: controller.periodController,
                readOnly: true,
                onTap: _pickPeriod,
                decoration: InputDecoration(
                  labelText: l10n.travler_form_roundtrip,
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                ),
                validator: (value) => controller.requiredText(value, l10n.travler_form_roundtrip),
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
