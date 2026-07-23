import 'package:flutter/material.dart';

import '../../../../core/widgtes/widgets.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../di/di.dart';
import '../state/traveler_planner_form_controller.dart';

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
      child: Column(
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
                  Expanded(child: Text(l10n.travler_form_roundtrip, style: textTheme.bodyMedium)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    controller.saveTravelerForm(context);
                  },
                  title: l10n.travler_form_save,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
