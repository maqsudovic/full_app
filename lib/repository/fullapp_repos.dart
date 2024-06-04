import 'package:full_app/model/fullapp_model.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  List<Todo> getAllTodos() {
    return _todos;
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(Todo todo) {
    _todos.removeWhere((t) => t.id == todo.id);
  }
}