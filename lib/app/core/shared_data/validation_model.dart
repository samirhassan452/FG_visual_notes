class ValidationModel {
  final bool? required;
  final String? requiredError;
  final int? minLength;
  final String? minLengthError;
  final int? maxLength;
  final String? maxLengthError;
  final String? pattern;
  final String? patternError;

  ValidationModel({
    this.required,
    this.requiredError,
    this.minLength,
    this.minLengthError,
    this.maxLength,
    this.maxLengthError,
    this.pattern,
    this.patternError,
  });
}
