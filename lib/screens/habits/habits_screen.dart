import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/tasks_service.dart';

import '../../widgets/ciantis_screen_shell.dart';
import '../../widgets/completion_ring.dart';
import '../../widgets/empty_state_card.dart';
import '../../widgets/filter_chip_widget.dart';
import '../../widgets/luxury_button.dart';
import '../../widgets/luxury_dialog.dart';
import '../../widgets/luxury_page_padding.dart';
import '../../widgets/luxury_scroll_view.dart';
import '../../widgets/luxury_section_spacing.dart';
import '../../widgets/luxury_text_field.dart';
import '../../widgets/page_header.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/section_title.dart';
import '../../widgets/stat_overview_card.dart';
import '../../widgets/task_tile.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() =>
      _HabitsScreenState();
}

class _HabitsScreenState
    extends State<HabitsScreen> {

  final TextEditingController
      searchController =
      TextEditingController();

  String searchQuery = '';

  String selectedFilter = 'All';

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final allTasks =
        TasksService.instance
            .getTasks();

    final completedCount =
        allTasks
            .where(
              (task) =>
                  task.completed,
            )
            .length;

    final pendingCount =
        allTasks
            .where(
              (task) =>
                  !task.completed,
            )
            .length;

    final completionRate =
        allTasks.isEmpty
            ? 0
            : ((completedCount /
                        allTasks.length) *
                    100)
                .toInt();

    final tasks =
        allTasks

            .where(
              (task) =>
                  task.title
                      .toLowerCase()
                      .contains(
                        searchQuery
                            .toLowerCase(),
                      ),
            )

            .where((task) {

              if (selectedFilter ==
                  'Completed') {
                return task.completed;
              }

              if (selectedFilter ==
                  'Pending') {
                return !task.completed;
              }

              return true;
            })

            .toList();

    return CiantisScreenShell(
      child: LuxuryPagePadding(
        child: LuxuryScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // HEADER
              const PageHeader(
                title: 'Habits',
                subtitle:
                    'Build consistency and daily discipline.',
              ),

              const LuxurySectionSpacing(),

              // STATS
              Container(
                padding:
                    const EdgeInsets.all(
                  22,
                ),

                decoration: BoxDecoration(
                  color:
                      Colors.white
                          .withOpacity(
                    .08,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),

                child: Row(
                  children: [

                    CompletionRing(
                      progress:
                          allTasks.isEmpty
                              ? 0
                              : completedCount /
                                  allTasks.length,
                    ),

                    const SizedBox(
                      width: 24,
                    ),

                    Expanded(
                      child: Column(
                        children: [

                          Row(
                            children: [

                              StatOverviewCard(
                                value:
                                    '$completedCount',

                                label:
                                    'Completed',

                                icon:
                                    Icons
                                        .check_circle,
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              StatOverviewCard(
                                value:
                                    '$pendingCount',

                                label:
                                    'Pending',

                                icon:
                                    Icons
                                        .schedule_outlined,
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          StatOverviewCard(
                            value:
                                '$completionRate%',

                            label:
                                'Success Rate',

                            icon:
                                Icons
                                    .trending_up_outlined,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const LuxurySectionSpacing(),

              // SEARCH
              SearchBarWidget(
                controller:
                    searchController,

                onChanged: (value) {
                  setState(() {
                    searchQuery =
                        value;
                  });
                },
              ),

              const LuxurySectionSpacing(),

              // FILTERS
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [

                  FilterChipWidget(
                    text: 'All',

                    selected:
                        selectedFilter ==
                            'All',

                    onTap: () {
                      setState(() {
                        selectedFilter =
                            'All';
                      });
                    },
                  ),

                  FilterChipWidget(
                    text: 'Completed',

                    selected:
                        selectedFilter ==
                            'Completed',

                    onTap: () {
                      setState(() {
                        selectedFilter =
                            'Completed';
                      });
                    },
                  ),

                  FilterChipWidget(
                    text: 'Pending',

                    selected:
                        selectedFilter ==
                            'Pending',

                    onTap: () {
                      setState(() {
                        selectedFilter =
                            'Pending';
                      });
                    },
                  ),
                ],
              ),

              const LuxurySectionSpacing(),

              // BUTTON
              LuxuryButton(
                text: 'Add Habit',
                icon: Icons.add_rounded,

                onPressed: () {
                  _showAddTaskDialog(
                    context,
                  );
                },
              ),

              const LuxurySectionSpacing(
                height: 36,
              ),

              // TASKS
              const SectionTitle(
                title: 'Daily Habits',
              ),

              if (tasks.isEmpty)
                const EmptyStateCard(
                  icon:
                      Icons.check_circle_outline,

                  title: 'No Habits Found',

                  subtitle:
                      'Try adding a habit or changing your filters.',
                )

              else
                ...tasks.map(
                  (task) =>
                      TaskTile(
                    task: task,

                    onToggle: () {

                      TasksService.instance
                          .toggleTask(
                        task.id,
                      );

                      setState(() {});
                    },

                    onDelete: () {

                      TasksService.instance
                          .deleteTask(
                        task.id,
                      );

                      setState(() {});
                    },
                  ),
                ),

              const LuxurySectionSpacing(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ADD TASK
  void _showAddTaskDialog(
    BuildContext context,
  ) {

    final controller =
        TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return LuxuryDialog(
          title: 'Add Habit',

          subtitle:
              'Create a new routine or daily task.',

          child: Column(
            children: [

              LuxuryTextField(
                hintText:
                    'Habit Title',

                icon:
                    Icons.check_circle_outline,

                controller:
                    controller,
              ),

              const SizedBox(
                height: 24,
              ),

              LuxuryButton(
                text: 'Save Habit',

                icon:
                    Icons.save_outlined,

                onPressed: () {

                  TasksService.instance
                      .addTask(
                    TaskModel(
                      id: DateTime.now()
                          .millisecondsSinceEpoch
                          .toString(),

                      title:
                          controller.text,

                      completed:
                          false,

                      createdAt:
                          DateTime.now(),
                    ),
                  );

                  Navigator.pop(
                    dialogContext,
                  );

                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
