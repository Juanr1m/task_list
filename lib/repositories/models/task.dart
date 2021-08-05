class Task {
  final String title;

  final DateTime date;

  final String status;

  Task({
    required this.title,
    required this.date,
    required this.status,
  });
  factory Task.fromMap(Map<String, dynamic> json) => Task(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['status'] = status;
    return map;
  }
}
