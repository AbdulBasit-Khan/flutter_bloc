import 'package:bloc/bloc.dart';
import 'package:flutter_blo/bloc/todo/bloc/to_do_event.dart';
import 'package:flutter_blo/bloc/todo/bloc/to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final List<String> todosList = [];
  ToDoBloc() : super(const ToDoState()) {
    on<AddToDoEvent>(_addToDoEvent);
    on<RemoveToDoEvent>(_removeToDoEvent);
  }
  void _addToDoEvent(AddToDoEvent event, Emitter<ToDoState> emit) {
    todosList.add(event.task);
    emit(state.copyWith(todosList: List.from(todosList)));
  }

  void _removeToDoEvent(RemoveToDoEvent event, Emitter<ToDoState> emit) {
    todosList.remove(event.task);
    emit(state.copyWith(todosList: List.from(todosList)));
  }
}
