import 'package:full_app/model/fullapp_model.dart';
import 'package:full_app/repository/fullapp_repos.dart';

class TodoController {
  final TodoRepository _todoRepository;

  TodoController(this._todoRepository);

  List<Todo> getAllTodos() {
    return _todoRepository.getAllTodos();
  }

  void addTodo(Todo todo) {
    _todoRepository.addTodo(todo);
  }

  void updateTodo(Todo todo) {
    _todoRepository.updateTodo(todo);
  }

  void deleteTodo(Todo todo) {
    _todoRepository.deleteTodo(todo);
  }
}