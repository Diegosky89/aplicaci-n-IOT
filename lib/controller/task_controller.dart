import 'package:flutter_application_1/models/task.dart';

class TaskController {
  final List<Task> _tasks = [
    Task(
      title: "ir a comprar pan",
      done: false,
      note: "No olvides la lista",
      due: DateTime.now().add(Duration(days: 1)),
    ),
  ];

  String _query = "";

  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks => List.unmodifiable(_tasks);

  String get query => _query;

  // ...existing code...
  List<Task> get filtered {
    final q = _query.toLowerCase();
    return _tasks.where((t) {
      final byfilter = switch (_filter) {
        TaskFilter.all => true,
        TaskFilter.pending => !t.done,
        TaskFilter.done => t.done,
      };
      final byquery =
          t.title.toLowerCase().contains(q) ||
          (t.note?.toLowerCase().contains(q) ?? false);
      return byfilter && byquery;
    }).toList();
  }
}
