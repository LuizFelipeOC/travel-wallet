mixin TravelerPlannerFormValidator {
  String? requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label é obrigatório';
    }
    return null;
  }

  String? requiredCurrency(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label é obrigatório';
    }

    final normalized = value.replaceAll(',', '.').replaceAll('R\$', '').trim();
    final parsed = double.tryParse(normalized);

    if (parsed == null || parsed < 0) {
      return '$label inválido';
    }

    return null;
  }
}
