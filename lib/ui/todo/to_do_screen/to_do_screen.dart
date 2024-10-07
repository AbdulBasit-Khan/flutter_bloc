import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/todo/bloc/to_do_bloc.dart';
import 'package:flutter_blo/bloc/todo/bloc/to_do_event.dart';
import 'package:flutter_blo/bloc/todo/bloc/to_do_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo Screen"),
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state.todosList.isEmpty) {
            return const Center(
              child: Text("No todos found"),
            );
          } else {
            return ListView.builder(
                itemCount: state.todosList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.todosList[index]),
                    trailing: IconButton(
                        onPressed: () {
                          context.read<ToDoBloc>().add(
                              RemoveToDoEvent(task: state.todosList[index]));
                        },
                        icon: const Icon(Icons.delete)),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < 10; i++) {
            context.read<ToDoBloc>().add(AddToDoEvent(task: "Task: $i"));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
