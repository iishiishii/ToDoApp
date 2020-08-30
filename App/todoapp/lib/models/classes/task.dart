class Task {
  List<Task> tasks;
  String note;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminder;
  int taskId;
  String title;

  Task(this.title, this.completed, this.taskId, this.note);

  factory Task.fromJson(Map<String, dynamic> parsedJson) {
    return Task(parsedJson['title'], parsedJson['completed'], parsedJson['id'],
        parsedJson['note']);
  }
}
