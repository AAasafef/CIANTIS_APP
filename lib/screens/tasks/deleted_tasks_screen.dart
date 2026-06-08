import 'package:flutter/material.dart';

import '../../models/task_item.dart';
import '../../services/tasks_service.dart';

class DeletedTasksScreen extends StatefulWidget {
  const DeletedTasksScreen({super.key});

  @override
  State<DeletedTasksScreen> createState() =>
      _DeletedTasksScreenState();
}

class _DeletedTasksScreenState
    extends State<DeletedTasksScreen> {
  final TasksService tasksService =
      TasksService.instance;

  @override
  Widget build(BuildContext context) {
    final deletedTasks = tasksService.deletedTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Deleted Tasks',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -1,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await tasksService.emptyTrash();
                      setState(() {});
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              if (deletedTasks.isEmpty)
                const _EmptyDeletedTasks()
              else
                Column(
                  children: deletedTasks.map((task) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _DeletedTaskTile(
                        task: task,
                        onRestore: () async {
                          await tasksService.restoreTask(task.id);
                          setState(() {});
                        },
                        onDeleteForever: () async {
                          await tasksService.permanentlyDeleteTask(task.id);
                          setState(() {});
                        },
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyDeletedTasks extends StatelessWidget {
  const _EmptyDeletedTasks();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Text(
        'No deleted tasks.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF2D241D),
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class _DeletedTaskTile extends StatelessWidget {
  final TaskItem task;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;

  const _DeletedTaskTile({
    required this.task,
    required this.onRestore,
    required this.onDeleteForever,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF6E5846),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF2D241D),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
            onPressed: onRestore,
            icon: const Icon(Icons.restore_rounded),
          ),
          IconButton(
            onPressed: onDeleteForever,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}