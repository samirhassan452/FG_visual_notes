/// table info
// table name
const String visualNotesTableName = "VisualNotes";

// table columns/fields
class VisualNoteFields {
  static final List<String> columns = [
    id,
    title,
    picture,
    description,
    createdTime,
    status,
  ];

  static const String id = "id";
  static const String title = "title";
  static const String picture = "picture";
  static const String description = "description";
  static const String createdTime = "createdTime";
  static const String status = "status";
}

/// model
class VisualNoteModel {
  final int? id;
  final String title;
  final String picture;
  final String description;
  final DateTime createdTime;
  final String status;

  VisualNoteModel({
    this.id,
    required this.title,
    required this.picture,
    required this.description,
    required this.createdTime,
    required this.status,
  });

  factory VisualNoteModel.fromJson(Map<String, dynamic> json) =>
      VisualNoteModel(
        id: json[VisualNoteFields.id] as int?,
        title: json[VisualNoteFields.title] as String,
        picture: json[VisualNoteFields.picture] as String,
        description: json[VisualNoteFields.description] as String,
        createdTime:
            DateTime.tryParse(json[VisualNoteFields.createdTime] as String) ??
                DateTime(1111, 1, 1),
        status: json[VisualNoteFields.status],
      );

  Map<String, dynamic> toJson() => {
        VisualNoteFields.id: id,
        VisualNoteFields.title: title,
        VisualNoteFields.picture: picture,
        VisualNoteFields.description: description,
        VisualNoteFields.createdTime: createdTime.toIso8601String(),
        VisualNoteFields.status: status,
      };

  VisualNoteModel copy({
    int? id,
    String? title,
    String? picture,
    String? description,
    DateTime? date,
    String? status,
  }) =>
      VisualNoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        picture: picture ?? this.picture,
        description: description ?? this.description,
        createdTime: date ?? createdTime,
        status: status ?? this.status,
      );

  static List<VisualNoteModel> getListOfVisualNotesFromListOfJson(List maps) =>
      maps.map((json) => VisualNoteModel.fromJson(json)).toList();
}
