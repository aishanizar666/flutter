import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListPage(),
      theme: ThemeData.light(),
      color: const Color.fromARGB(255, 171, 4, 121),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  void change(int index, bool value) {
    setState(() {
      tasks[index].isCompleted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tasks")),
      body: Column(
        children: [
          Text(
            "Completed Tasks ${tasks.where((task) => task.isCompleted).length}/${tasks.length}",
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: tasks.length,
              itemBuilder: (context, index) => TaskItem(
                isCompleted: tasks[index].isCompleted,
                title: tasks[index].title,
                onChanged: (value) {
                  change(index, value);
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompletedTasksPage()),
              );
            },
            child: Text("The completed Tasks"),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final void Function(bool) onChanged;
  const TaskItem({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Checkbox(
          value: isCompleted,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}

class CompletedTasksPage extends StatelessWidget {
  CompletedTasksPage({super.key});
  final completedTasks = tasks.where((task) => task.isCompleted).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("completed Tasks")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: completedTasks.length,
        itemBuilder: (context, index) => Text(completedTasks[index].title),
      ),
    );
  }
}

List<Task> tasks = [
  Task(title: "Cooking", isCompleted: true),
  Task(title: "Studying", isCompleted: false),
  Task(title: "cleaning", isCompleted: true),
];

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, required this.isCompleted});
}
