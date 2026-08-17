import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgtes/custom_buttons/cusom_button.dart';
import '../data/models/expense.dart';
import 'category_chip.dart';
import 'new_expense_result.dart';

export 'new_expense_result.dart';
import 'expense_category_theme.dart';

/// Bottom sheet used to add an expense to the trip.
class NewExpenseSheet extends StatefulWidget {
  final DateTime initialDate;

  const NewExpenseSheet({super.key, required this.initialDate});

  static Future<NewExpenseResult?> show(BuildContext context, {required DateTime initialDate}) {
    return showModalBottomSheet<NewExpenseResult>(
      context: context,
      isScrollControlled: true,
      builder: (context) => NewExpenseSheet(initialDate: initialDate),
    );
  }

  @override
  State<NewExpenseSheet> createState() => _NewExpenseSheetState();
}

class _NewExpenseSheetState extends State<NewExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  late ExpenseCategory _category = ExpenseCategory.food;
  late DateTime _date = widget.initialDate;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  double? _parseAmount() {
    return double.tryParse(_amountController.text.replaceAll(',', '.').trim());
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(_date.year - 2),
      lastDate: DateTime(_date.year + 5),
    );

    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    Navigator.of(context).pop(
      NewExpenseResult(
        description: _descriptionController.text.trim(),
        amount: _parseAmount()!,
        category: _category,
        date: _date,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, MediaQuery.viewInsetsOf(context).bottom + 24),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.details_add_expense, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 24),
              TextFormField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(labelText: l10n.details_expense_description),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? '${l10n.details_expense_description} é obrigatório'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(labelText: l10n.details_expense_amount),
                validator: (value) {
                  final amount = _parseAmount();

                  if (value == null || value.trim().isEmpty) {
                    return '${l10n.details_expense_amount} é obrigatório';
                  }

                  if (amount == null || amount <= 0) {
                    return '${l10n.details_expense_amount} inválido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                l10n.details_expense_category,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final category in ExpenseCategory.values)
                    CategoryChip(
                      label: category.label(l10n),
                      icon: category.icon,
                      color: category.color,
                      isSelected: _category == category,
                      onTap: () => setState(() => _category = category),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: ValueKey(_date),
                readOnly: true,
                onTap: _pickDate,
                initialValue:
                    '${_date.day.toString().padLeft(2, '0')}/'
                    '${_date.month.toString().padLeft(2, '0')}/${_date.year}',
                decoration: InputDecoration(
                  labelText: l10n.details_expense_date,
                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                ),
              ),
              const SizedBox(height: 28),
              CustomButton(title: l10n.details_expense_save, onPressed: _onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
