mixin AuthValidator {
  static final RegExp _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  String? requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label é obrigatório';
    }

    return null;
  }

  String? requiredEmail(String? value, String label) {
    final required = requiredText(value, label);

    if (required != null) {
      return required;
    }

    if (!_emailRegExp.hasMatch(value!.trim())) {
      return '$label inválido';
    }

    return null;
  }

  String? requiredPassword(String? value, String label) {
    final required = requiredText(value, label);

    if (required != null) {
      return required;
    }

    if (value!.trim().length < 6) {
      return '$label deve ter no mínimo 6 caracteres';
    }

    return null;
  }

  String? requiredPasswordConfirmation(String? value, String password, String label) {
    final required = requiredText(value, label);

    if (required != null) {
      return required;
    }

    if (value!.trim() != password.trim()) {
      return 'As senhas não conferem';
    }

    return null;
  }
}
