import 'package:flutter/material.dart';

import '../../../../core/widgtes/widgets.dart';
import '../../../../../l10n/app_localizations.dart';

class TravelerForm extends StatefulWidget {
  const TravelerForm({super.key});

  @override
  State<TravelerForm> createState() => _TravelerFormState();
}

class _TravelerFormState extends State<TravelerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: _nameController,
            decoration: InputDecoration(labelText: l10n.travler_form_name),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? '${l10n.travler_form_name} é obrigatório' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: _budgetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.travler_form_budget),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return '${l10n.travler_form_budget} é obrigatório';
              final text = v.replaceAll(',', '.').replaceAll('R\$', '').trim();
              final value = double.tryParse(text);
              if (value == null || value < 0) return '${l10n.travler_form_budget} inválido';
              return null;
            },
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
                    FocusScope.of(context).unfocus(); // Fecha o teclado
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
