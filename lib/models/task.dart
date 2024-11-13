class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime dueDate;
  final DateTime lastUpdated;

  Task({
    required this.id,
    required this.title,
    this.description = "",
    this.isCompleted = false,
    required this.createdAt,
    required this.dueDate,
    required this.lastUpdated,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      isCompleted: json['isCompleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: DateTime.parse(json['dueDate']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
