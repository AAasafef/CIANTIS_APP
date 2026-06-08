import 'package:flutter/material.dart';

import '../../models/task_item.dart';

import '../../services/tasks_service.dart';

import 'deleted_tasks_screen.dart';

class TasksScreen extends StatefulWidget {
  final String spaceId;
  final String spaceName;
  final String? linkedItemId;

  const TasksScreen({
    super.key,
    required this.spaceId,
    required this.spaceName,
    this.linkedItemId,
  });

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}

class _TasksScreenState
    extends State<TasksScreen> {
  final TasksService tasksService =
      TasksService.instance;

  List<TaskItem> get tasks {
    return tasksService.tasksForSpace(
      widget.spaceId,
    );
  }

  Future<void> _openTrash() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const DeletedTasksScreen(),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _createTask() async {
    final titleController =
        TextEditingController();

    final notesController =
        TextEditingController();

    await showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(
              context,
            ).viewInsets.bottom,
          ),
          child: Container(
            margin:
                const EdgeInsets.all(
              18,
            ),
            padding:
                const EdgeInsets.all(
              22,
            ),
            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                30,
              ),
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  'New Task',
                  style: TextStyle(
                    color: Color(
                      0xFF2D241D,
                    ),
                    fontSize: 30,
                    fontWeight:
                        FontWeight
                            .w300,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextField(
                  controller:
                      titleController,
                  decoration:
                      _inputDecoration(
                    'Task title',
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                TextField(
                  controller:
                      notesController,
                  maxLines: 5,
                  decoration:
                      _inputDecoration(
                    'Notes',
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                GestureDetector(
                  onTap: () async {
                    final title =
                        titleController
                            .text
                            .trim();

                    if (title
                        .isEmpty) {
                      return;
                    }

                    await tasksService
                        .createTask(
                      title: title,
                      notes:
                          notesController
                              .text,
                      spaceId:
                          widget
                              .spaceId,
                      spaceName:
                          widget
                              .spaceName,
                      linkedItemId:
                          widget
                              .linkedItemId,
                    );

                    if (mounted) {
                      Navigator.pop(
                        context,
                      );

                      setState(() {});
                    }
                  },
                  child:
                      const Text(
                    'CREATE TASK',
                    style:
                        TextStyle(
                      color: Color(
                        0xFFC6A06B,
                      ),
                      fontSize: 10,
                      fontWeight:
                          FontWeight
                              .w300,
                      letterSpacing:
                          2.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _completeTask(
    TaskItem task,
  ) async {
    await tasksService.completeTask(
      task.id,
    );

    setState(() {});
  }

  Future<void> _reopenTask(
    TaskItem task,
  ) async {
    await tasksService.reopenTask(
      task.id,
    );

    setState(() {});
  }

  Future<void> _deleteTask(
    TaskItem task,
  ) async {
    await tasksService.deleteTask(
      task.id,
    );

    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final currentTasks = tasks;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            const Color(0xFF2D241D),
        elevation: 0,
        onPressed:
            _createTask,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child:
            SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            120,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                      child:
                          const Icon(
                        Icons
                            .arrow_back,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 16,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Text(
                          'Tasks',
                          style:
                              TextStyle(
                            fontSize:
                                40,
                            fontWeight:
                                FontWeight
                                    .w300,
                            letterSpacing:
                                -1,
                            color:
                                Color(
                              0xFF2D241D,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          widget
                              .spaceName
                              .toUpperCase(),
                          style:
                              const TextStyle(
                            fontSize:
                                11,
                            fontWeight:
                                FontWeight
                                    .w300,
                            letterSpacing:
                                3,
                            color:
                                Color(
                              0xFF8B7D72,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap:
                        _openTrash,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                      child:
                          const Icon(
                        Icons
                            .delete_outline_rounded,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 26,
              ),

              if (currentTasks
                  .isEmpty)
                const _EmptyTasks()
              else
                Column(
                  children:
                      currentTasks.map(
                    (task) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child:
                            _TaskTile(
                          task:
                              task,
                          onComplete:
                              () {
                            if (task
                                .isCompleted) {
                              _reopenTask(
                                task,
                              );
                            } else {
                              _completeTask(
                                task,
                              );
                            }
                          },
                          onDelete:
                              () {
                            _deleteTask(
                              task,
                            );
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration
      _inputDecoration(
    String hint,
  ) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),
        borderSide:
            BorderSide.none,
      ),
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
    );
  }
}

class _EmptyTasks
    extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(
        30,
      ),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(.9),
        borderRadius:
            BorderRadius.circular(
          28,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),
            child: const Icon(
              Icons
                  .check_circle_outline,
              color: Color(
                0xFF6E5846,
              ),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'No tasks yet',
            style: TextStyle(
              color:
                  Color(
                0xFF2D241D,
              ),
              fontSize: 22,
              fontWeight:
                  FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTile
    extends StatelessWidget {
  final TaskItem task;

  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const _TaskTile({
    required this.task,
    required this.onComplete,
    required this.onDelete,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(.92),
        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onComplete,
            child: Container(
              height: 28,
              width: 28,
              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,
                color: task
                        .isCompleted
                    ? const Color(
                        0xFFB08D6D,
                      )
                    : Colors
                        .transparent,
                border: Border.all(
                  color:
                      const Color(
                    0xFFB08D6D,
                  ),
                ),
              ),
              child: task
                      .isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color:
                          Colors.white,
                    )
                  : null,
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  task.title,
                  style:
                      TextStyle(
                    color: const Color(
                      0xFF2D241D,
                    ),
                    fontSize: 16,
                    fontWeight:
                        FontWeight
                            .w400,
                    decoration: task
                            .isCompleted
                        ? TextDecoration
                            .lineThrough
                        : null,
                  ),
                ),

                if (task.notes
                    .isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      task.notes,
                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          TextStyle(
                        color: Colors
                            .black
                            .withOpacity(
                          .5,
                        ),
                        fontSize:
                            12,
                        fontWeight:
                            FontWeight
                                .w300,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          IconButton(
            onPressed:
                onDelete,
            icon: const Icon(
              Icons.close_rounded,
              color: Color(
                0xFF8B7D72,
              ),
            ),
          ),
        ],
      ),
    );
  }
}