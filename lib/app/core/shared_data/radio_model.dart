class RadioModel {
  final int id;
  final dynamic radioValue;
  final dynamic radioGroupValue;
  final String titleKey;

  RadioModel({
    required this.id,
    required this.radioValue,
    required this.radioGroupValue,
    required this.titleKey,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) => RadioModel(
        id: json['id'],
        radioValue: json['radioValue'],
        radioGroupValue: json['radioGroupValue'],
        titleKey: json['titleKey'],
      );

  static List<RadioModel> getListOfRadioButtonsFromListOfJsons(
          List<dynamic> json) =>
      List.generate(
        json.length,
        (index) => RadioModel.fromJson(json[index]),
      );
}
