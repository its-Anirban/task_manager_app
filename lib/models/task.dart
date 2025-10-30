class Task {

  Task({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
      );
  int id;
  String title;
  String description;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
