import "package:email_validator/email_validator.dart";

class FormValidation {
  static String? Function(String? value) fieldHasInputValidator(
    String errorText,
  ) =>
      (value) => value?.isEmpty == false ? null : errorText;

  static String? Function(String? value) fieldIsValidEmail(
    String errorText,
  ) =>
      (value) =>
          value != null && EmailValidator.validate(value) ? null : errorText;

  static String? Function(String? value) fieldMatchesRegex(
    RegExp regExp,
    String errorText,
  ) =>
      (value) => value != null && regExp.hasMatch(value) ? null : errorText;
}

class FormValidator {
  const FormValidator({required this.validators});
  final List<String? Function(String? value)> validators;

  String? validate(String? value) => validators
      .map((validator) => validator(value))
      .firstWhere((error) => error != null, orElse: () => null);
}
