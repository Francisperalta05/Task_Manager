import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  int? id;
  String title;
  String description;
  int completed;
  DateTime createdAt;
  DateTime lastUpdated;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
    required this.lastUpdated,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        createdAt: DateTime.parse(json["createdAt"]),
        lastUpdated: DateTime.parse(json["lastUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "completed": completed,
        "createdAt": createdAt.toIso8601String(),
        "lastUpdated": lastUpdated.toIso8601String(),
      };
}
