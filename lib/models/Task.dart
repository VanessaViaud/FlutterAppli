

class Task {
  int id;
  String title;
  bool completed;

  Task (this.id, this.title, this.completed);

  static Task fromJson(Map<String, dynamic> json) {
    return Task(json['id'], json['title'], json['completed']);
  }
}