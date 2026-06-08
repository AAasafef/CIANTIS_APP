import 'package:flutter/material.dart';

import '../models/task_model.dart';

import '../theme/ciantis_theme.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;

  final VoidCallback onToggle;

  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      padding: const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(
          .08,
        ),

        borderRadius:
            BorderRadius.circular(
          22,
        ),
      ),

      child: Row(
        children: [

          GestureDetector(
            onTap: onToggle,

            child: Container(
              height: 26,
              width: 26,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color:
                      CiantisTheme.white,
                ),

                color: task.completed
                    ? CiantisTheme.white
                    : Colors.transparent,
              ),

              child: task.completed
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color:
                          Colors.black,
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              task.title,

              style: TextStyle(
                color:
                    CiantisTheme.white,

                fontSize: 15,

                decoration:
                    task.completed
                        ? TextDecoration
                            .lineThrough
                        : null,

                decorationColor:
                    Colors.white54,
              ),
            ),
          ),

          GestureDetector(
            onTap: onDelete,

            child: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
