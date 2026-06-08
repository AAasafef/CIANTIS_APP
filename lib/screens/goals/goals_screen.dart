import 'package:flutter/material.dart';

import '../../models/goal_model.dart';
import '../../services/activity_helper.dart';
import '../../services/goals_service.dart';
import '../../services/reminders_service.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({
    super.key,
  });

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  static const String spaceId = 'goals';
  static const String spaceName = 'Goals';

  static const List<String> categories = [
    'Daily Focus',
    'Wellness',
    'Beauty',
    'School',
    'Money',
    'Business',
    'Family',
    'Spiritual',
    'Long-Term Vision',
  ];

  @override
  Widget build(BuildContext context) {
    final goals = GoalsService.instance.getGoals();

    final totalGoals = goals.length;
    final inProgress = goals.where((goal) {
      return goal.progress > 0 && goal.progress < 1;
    }).length;
    final completed = goals.where((goal) {
      return goal.progress >= 1;
    }).length;
    final notStarted = goals.where((goal) {
      return goal.progress <= 0;
    }).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(
                title: 'Goals',
                subtitle: 'GRID MENU',
                showBack: false,
                onAdd: () async {
                  await _openCreateGoal();
                },
              ),
              const SizedBox(height: 22),
              _StartCard(
                hasGoals: totalGoals > 0,
                onCreate: () async {
                  await _openCreateGoal();
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Overview',
                style: TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.3,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _MiniStatCard(
                      icon: Icons.track_changes_rounded,
                      value: totalGoals.toString(),
                      label: 'Total',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MiniStatCard(
                      icon: Icons.trending_up_rounded,
                      value: inProgress.toString(),
                      label: 'Progress',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MiniStatCard(
                      icon: Icons.check_circle_outline_rounded,
                      value: completed.toString(),
                      label: 'Complete',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MiniStatCard(
                      icon: Icons.star_border_rounded,
                      value: notStarted.toString(),
                      label: 'Not Started',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Goal Categories',
                style: TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.3,
                ),
              ),
              const SizedBox(height: 12),
              ...categories.map((category) {
                final categoryGoals =
                    GoalsService.instance.getGoalsByCategory(category);

                final categoryInProgress = categoryGoals.where((goal) {
                  return goal.progress > 0 && goal.progress < 1;
                }).length;

                return _CategoryRow(
                  category: category,
                  goalsCount: categoryGoals.length,
                  inProgressCount: categoryInProgress,
                  onTap: () async {
                    await _openCategory(category);
                  },
                );
              }),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Progress, not perfection.',
                  style: TextStyle(
                    color: const Color(0xFFB9895D).withOpacity(.82),
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    letterSpacing: .4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCreateGoal({
    String? category,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return GoalCreateScreen(
            startingCategory: category ?? 'Daily Focus',
          );
        },
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _openCategory(String category) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return GoalCategoryScreen(
            category: category,
          );
        },
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }
}

class GoalCreateScreen extends StatefulWidget {
  final String startingCategory;

  const GoalCreateScreen({
    super.key,
    required this.startingCategory,
  });

  @override
  State<GoalCreateScreen> createState() => _GoalCreateScreenState();
}

class _GoalCreateScreenState extends State<GoalCreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  late String selectedCategory;
  double initialProgress = 0;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.startingCategory;
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _saveGoal() async {
    final title = titleController.text.trim();
    final notes = notesController.text.trim();

    if (title.isEmpty) return;

    final goal = GoalModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      subtitle: notes,
      progress: initialProgress,
      category: selectedCategory,
    );

    GoalsService.instance.addGoal(goal);

    await ActivityHelper.created(
      title: 'Goal Created',
      description: title,
      spaceId: _GoalsMeta.spaceId,
      spaceName: _GoalsMeta.spaceName,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            title: 'Create Goal',
            subtitle: '',
            showBack: true,
            actionText: 'Save',
            onAction: _saveGoal,
          ),
          const SizedBox(height: 22),
          _SoftTextField(
            controller: titleController,
            hintText: 'Goal Title',
            minLines: 1,
            maxLines: 1,
          ),
          const SizedBox(height: 14),
          _SoftTextField(
            controller: notesController,
            hintText: 'What do you want to achieve?',
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 24),
          const _FieldLabel('Category'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _GoalsMeta.categories.map((category) {
              return _PillChip(
                label: category,
                selected: selectedCategory == category,
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              const Expanded(
                child: _FieldLabel('Set Initial Progress'),
              ),
              Text(
                '${(initialProgress * 100).round()}%',
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFC6A06B),
              inactiveTrackColor: const Color(0xFFE2D8CD),
              thumbColor: const Color(0xFF8B6F55),
              overlayColor: const Color(0xFFC6A06B).withOpacity(.14),
            ),
            child: Slider(
              value: initialProgress,
              onChanged: (value) {
                setState(() {
                  initialProgress = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GoalCategoryScreen extends StatefulWidget {
  final String category;

  const GoalCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<GoalCategoryScreen> createState() => _GoalCategoryScreenState();
}

class _GoalCategoryScreenState extends State<GoalCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final goals = GoalsService.instance.getGoalsByCategory(widget.category);

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(
                title: 'Goals',
                subtitle: 'GRID MENU',
                showBack: false,
                onAdd: () async {
                  await _openCreate();
                },
              ),
              const SizedBox(height: 18),
              const Text(
                'Categories',
                style: TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 12),
              ..._GoalsMeta.categories.map((category) {
                final categoryGoals =
                    GoalsService.instance.getGoalsByCategory(category);

                final expanded = category == widget.category;

                return _ExpandableCategoryCard(
                  category: category,
                  expanded: expanded,
                  goals: categoryGoals,
                  onCategoryTap: () {
                    if (category == widget.category) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return GoalCategoryScreen(
                            category: category,
                          );
                        },
                      ),
                    );
                  },
                  onGoalTap: (goal) async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return GoalDetailScreen(
                            goalId: goal.id,
                          );
                        },
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  onMore: (goal) async {
                    await _showGoalActions(goal);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCreate() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return GoalCreateScreen(
            startingCategory: widget.category,
          );
        },
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _showGoalActions(GoalModel goal) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return GoalActionSheet(
          goal: goal,
        );
      },
    );

    if (mounted) {
      setState(() {});
    }
  }
}

class GoalDetailScreen extends StatefulWidget {
  final String goalId;

  const GoalDetailScreen({
    super.key,
    required this.goalId,
  });

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  GoalModel? get goal {
    final goals = GoalsService.instance.getGoals();

    for (final item in goals) {
      if (item.id == widget.goalId) {
        return item;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentGoal = goal;

    if (currentGoal == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF4EFE8),
        body: SafeArea(
          child: Center(
            child: Text(
              'Goal not found.',
              style: TextStyle(
                color: Color(0xFF241D18),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      );
    }

    final percent = (currentGoal.progress * 100).round();

    return _PhoneScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            title: currentGoal.title,
            subtitle: '',
            showBack: true,
            showMore: true,
            onMore: () async {
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return GoalActionSheet(
                    goal: currentGoal,
                  );
                },
              );

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 18),
          Center(
            child: _LargeProgressRing(
              progress: currentGoal.progress,
              size: 126,
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Text(
              currentGoal.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 28,
                fontWeight: FontWeight.w300,
                letterSpacing: -.6,
              ),
            ),
          ),
          if (currentGoal.subtitle.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Center(
              child: Text(
                currentGoal.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF6F6258),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 1.35,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0E6DB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                currentGoal.category,
                style: const TextStyle(
                  color: Color(0xFF8B6F55),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _DetailActionButton(
                  icon: Icons.edit_outlined,
                  label: 'Edit',
                  onTap: () async {
                    await _openEdit(currentGoal);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DetailActionButton(
                  icon: Icons.tune_rounded,
                  label: 'Update',
                  onTap: () async {
                    await _openProgress(currentGoal);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DetailActionButton(
                  icon: Icons.notifications_none_rounded,
                  label: 'Reminder',
                  onTap: () async {
                    await _openReminder(currentGoal);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DetailActionButton(
                  icon: Icons.more_horiz_rounded,
                  label: 'More',
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return GoalActionSheet(
                          goal: currentGoal,
                        );
                      },
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Progress',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 18,
              fontWeight: FontWeight.w300,
              letterSpacing: -.2,
            ),
          ),
          const SizedBox(height: 14),
          _ProgressHistoryTile(
            percent: percent,
            label: 'Progress set to $percent%',
          ),
          if (percent == 0)
            const _ProgressHistoryTile(
              percent: 0,
              label: 'Waiting for your first update',
            ),
        ],
      ),
    );
  }

  Future<void> _openEdit(GoalModel goal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return GoalEditScreen(
            goal: goal,
          );
        },
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _openProgress(GoalModel goal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return GoalProgressScreen(
            goal: goal,
          );
        },
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _openReminder(GoalModel goal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return GoalReminderScreen(
            goal: goal,
          );
        },
      ),
    );
  }
}

class GoalEditScreen extends StatefulWidget {
  final GoalModel goal;

  const GoalEditScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalEditScreen> createState() => _GoalEditScreenState();
}

class _GoalEditScreenState extends State<GoalEditScreen> {
  late final TextEditingController titleController;
  late final TextEditingController notesController;
  late String selectedCategory;
  late double progress;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.goal.title,
    );

    notesController = TextEditingController(
      text: widget.goal.subtitle,
    );

    selectedCategory = widget.goal.category;
    progress = widget.goal.progress;
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = titleController.text.trim();

    if (title.isEmpty) return;

    final wasIncomplete = widget.goal.progress < 1;
    final nowComplete = progress >= 1;

    GoalsService.instance.updateGoal(
      widget.goal.copyWith(
        title: title,
        subtitle: notesController.text.trim(),
        category: selectedCategory,
        progress: progress,
      ),
    );

    await ActivityHelper.updated(
      title: 'Goal Updated',
      description: title,
      spaceId: _GoalsMeta.spaceId,
      spaceName: _GoalsMeta.spaceName,
    );

    if (wasIncomplete && nowComplete) {
      await ActivityHelper.completed(
        title: 'Goal Completed',
        description: title,
        spaceId: _GoalsMeta.spaceId,
        spaceName: _GoalsMeta.spaceName,
      );
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            title: 'Edit Goal',
            subtitle: '',
            showBack: true,
            actionText: 'Save',
            onAction: _save,
          ),
          const SizedBox(height: 22),
          _SoftTextField(
            controller: titleController,
            hintText: 'Goal Title',
            minLines: 1,
            maxLines: 1,
          ),
          const SizedBox(height: 14),
          _SoftTextField(
            controller: notesController,
            hintText: 'Notes',
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 24),
          const _FieldLabel('Category'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _GoalsMeta.categories.map((category) {
              return _PillChip(
                label: category,
                selected: selectedCategory == category,
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              const Expanded(
                child: _FieldLabel('Progress'),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFC6A06B),
              inactiveTrackColor: const Color(0xFFE2D8CD),
              thumbColor: const Color(0xFF8B6F55),
              overlayColor: const Color(0xFFC6A06B).withOpacity(.14),
            ),
            child: Slider(
              value: progress,
              onChanged: (value) {
                setState(() {
                  progress = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GoalProgressScreen extends StatefulWidget {
  final GoalModel goal;

  const GoalProgressScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalProgressScreen> createState() => _GoalProgressScreenState();
}

class _GoalProgressScreenState extends State<GoalProgressScreen> {
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = widget.goal.progress;
  }

  Future<void> _save() async {
    final wasIncomplete = widget.goal.progress < 1;
    final nowComplete = progress >= 1;

    GoalsService.instance.updateGoal(
      widget.goal.copyWith(
        progress: progress,
      ),
    );

    await ActivityHelper.updated(
      title: 'Goal Progress Updated',
      description: widget.goal.title,
      spaceId: _GoalsMeta.spaceId,
      spaceName: _GoalsMeta.spaceName,
    );

    if (wasIncomplete && nowComplete) {
      await ActivityHelper.completed(
        title: 'Goal Completed',
        description: widget.goal.title,
        spaceId: _GoalsMeta.spaceId,
        spaceName: _GoalsMeta.spaceName,
      );
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            title: 'Update Progress',
            subtitle: '',
            showBack: true,
            actionText: 'Save',
            onAction: _save,
          ),
          const SizedBox(height: 24),
          _SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.goal.title,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.2,
                  ),
                ),
                if (widget.goal.subtitle.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.goal.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      height: 1.35,
                    ),
                  ),
                ],
                const SizedBox(height: 34),
                Center(
                  child: _LargeProgressRing(
                    progress: progress,
                    size: 150,
                  ),
                ),
                const SizedBox(height: 34),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFFC6A06B),
                    inactiveTrackColor: const Color(0xFFE2D8CD),
                    thumbColor: const Color(0xFF8B6F55),
                    overlayColor: const Color(0xFFC6A06B).withOpacity(.14),
                  ),
                  child: Slider(
                    value: progress,
                    onChanged: (value) {
                      setState(() {
                        progress = value;
                      });
                    },
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0%',
                      style: TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      '100%',
                      style: TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      progress = 1;
                    });
                  },
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF8F4),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFE2D8CD),
                        width: .7,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Color(0xFF8B6F55),
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Mark as Completed',
                          style: TextStyle(
                            color: Color(0xFF241D18),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GoalReminderScreen extends StatefulWidget {
  final GoalModel goal;

  const GoalReminderScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalReminderScreen> createState() => _GoalReminderScreenState();
}

class _GoalReminderScreenState extends State<GoalReminderScreen> {
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(
    const Duration(days: 1),
  );

  TimeOfDay selectedTime = const TimeOfDay(
    hour: 8,
    minute: 0,
  );

  String repeatLabel = 'None';

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 3650),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF241D18),
              onPrimary: Color(0xFFFFF9F1),
              surface: Color(0xFFFBF8F4),
              onSurface: Color(0xFF241D18),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null) return;

    setState(() {
      selectedDate = date;
    });
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF241D18),
              onPrimary: Color(0xFFFFF9F1),
              surface: Color(0xFFFBF8F4),
              onSurface: Color(0xFF241D18),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null) return;

    setState(() {
      selectedTime = time;
    });
  }

  Future<void> _saveReminder() async {
    final remindAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    await RemindersService.instance.createReminder(
      title: widget.goal.title,
      notes: notesController.text.trim(),
      spaceId: _GoalsMeta.spaceId,
      spaceName: _GoalsMeta.spaceName,
      remindAt: remindAt,
      linkedItemId: widget.goal.id,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _PhoneScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            title: 'Add Reminder',
            subtitle: '',
            showBack: true,
            actionText: 'Save',
            onAction: _saveReminder,
          ),
          const SizedBox(height: 24),
          _SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Goal'),
                const SizedBox(height: 8),
                Text(
                  widget.goal.title,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _FieldLabel('Remind Me'),
          const SizedBox(height: 12),
          _ReminderRow(
            label: 'Date',
            value: _formatDate(selectedDate),
            icon: Icons.calendar_today_outlined,
            onTap: _pickDate,
          ),
          const SizedBox(height: 10),
          _ReminderRow(
            label: 'Time',
            value: selectedTime.format(context),
            icon: Icons.access_time_rounded,
            onTap: _pickTime,
          ),
          const SizedBox(height: 10),
          _ReminderRow(
            label: 'Repeat',
            value: repeatLabel,
            icon: Icons.chevron_right_rounded,
            onTap: () {
              setState(() {
                repeatLabel = repeatLabel == 'None' ? 'Every Day' : 'None';
              });
            },
          ),
          const SizedBox(height: 24),
          const _FieldLabel('Notes'),
          const SizedBox(height: 12),
          _SoftTextField(
            controller: notesController,
            hintText: 'Add a note...',
            minLines: 5,
            maxLines: 8,
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class GoalActionSheet extends StatelessWidget {
  final GoalModel goal;

  const GoalActionSheet({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 34),
      decoration: const BoxDecoration(
        color: Color(0xFFFBF8F4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFD7C8BB),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 18),
          _ActionSheetItem(
            icon: Icons.edit_outlined,
            label: 'Edit Goal',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return GoalEditScreen(
                      goal: goal,
                    );
                  },
                ),
              );
            },
          ),
          _ActionSheetItem(
            icon: Icons.tune_rounded,
            label: 'Update Progress',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return GoalProgressScreen(
                      goal: goal,
                    );
                  },
                ),
              );
            },
          ),
          _ActionSheetItem(
            icon: Icons.notifications_none_rounded,
            label: 'Add Reminder',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return GoalReminderScreen(
                      goal: goal,
                    );
                  },
                ),
              );
            },
          ),
          _ActionSheetItem(
            icon: Icons.copy_rounded,
            label: 'Duplicate Goal',
            onTap: () async {
              final duplicate = goal.copyWith(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                title: '${goal.title} Copy',
                progress: 0,
              );

              GoalsService.instance.addGoal(duplicate);

              await ActivityHelper.created(
                title: 'Goal Duplicated',
                description: goal.title,
                spaceId: _GoalsMeta.spaceId,
                spaceName: _GoalsMeta.spaceName,
              );

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
          _ActionSheetItem(
            icon: Icons.delete_outline_rounded,
            label: 'Delete Goal',
            destructive: true,
            onTap: () async {
              Navigator.pop(context);

              await showDialog(
                context: context,
                builder: (_) {
                  return GoalDeleteDialog(
                    goal: goal,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class GoalDeleteDialog extends StatelessWidget {
  final GoalModel goal;

  const GoalDeleteDialog({
    super.key,
    required this.goal,
  });

  Future<void> _delete(BuildContext context) async {
    GoalsService.instance.deleteGoal(goal.id);

    await ActivityHelper.deleted(
      title: 'Goal Deleted',
      description: goal.title,
      spaceId: _GoalsMeta.spaceId,
      spaceName: _GoalsMeta.spaceName,
    );

    if (!context.mounted) return;

    Navigator.pop(context);
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.16),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete Goal?',
              style: TextStyle(
                color: Color(0xFF241D18),
                fontSize: 22,
                fontWeight: FontWeight.w300,
                letterSpacing: -.3,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Are you sure you want to delete this goal? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6F6258),
                fontSize: 13,
                fontWeight: FontWeight.w300,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF241D18),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _delete(context);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Color(0xFFD96161),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalsMeta {
  static const String spaceId = 'goals';
  static const String spaceName = 'Goals';

  static const List<String> categories = [
    'Daily Focus',
    'Wellness',
    'Beauty',
    'School',
    'Money',
    'Business',
    'Family',
    'Spiritual',
    'Long-Term Vision',
  ];
}

class _PhoneScaffold extends StatelessWidget {
  final Widget child;

  const _PhoneScaffold({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          child: child,
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;
  final bool showMore;
  final VoidCallback? onAdd;
  final VoidCallback? onMore;
  final VoidCallback? onAction;
  final String? actionText;

  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.showBack,
    this.showMore = false,
    this.onAdd,
    this.onMore,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final useCompactTitle = title.length > 18;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBack) ...[
          _CircleIconButton(
            icon: Icons.close_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment:
                showBack ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: showBack ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF241D18),
                  fontSize: useCompactTitle ? 22 : 40,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  letterSpacing: useCompactTitle ? -.5 : -1.4,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 9),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (actionText != null)
          GestureDetector(
            onTap: onAction,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF241D18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                actionText!,
                style: const TextStyle(
                  color: Color(0xFFFFF9F1),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          )
        else if (showMore)
          _CircleIconButton(
            icon: Icons.more_horiz_rounded,
            onTap: onMore,
          )
        else
          _CircleIconButton(
            icon: Icons.add_rounded,
            onTap: onAdd,
            dark: true,
          ),
      ],
    );
  }
}

class _StartCard extends StatelessWidget {
  final bool hasGoals;
  final VoidCallback onCreate;

  const _StartCard({
    required this.hasGoals,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.045),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasGoals
                      ? 'Keep building your future.'
                      : 'Start building your future.',
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    height: 1.18,
                    letterSpacing: -.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'No fake entries. Only the goals that matter to you.',
                  style: TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onCreate,
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF241D18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          color: Color(0xFFFFF9F1),
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Create Goal',
                          style: TextStyle(
                            color: Color(0xFFFFF9F1),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Container(
            height: 112,
            width: 78,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(38),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .8,
              ),
            ),
            child: const Icon(
              Icons.local_florist_outlined,
              color: Color(0xFFC6A06B),
              size: 42,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _MiniStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.92),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF8B6F55),
            size: 19,
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 9,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final String category;
  final int goalsCount;
  final int inProgressCount;
  final VoidCallback onTap;

  const _CategoryRow({
    required this.category,
    required this.goalsCount,
    required this.inProgressCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF8F4).withOpacity(.92),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE2D8CD),
              width: .7,
            ),
          ),
          child: Row(
            children: [
              _CategoryIconBubble(category: category),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF241D18),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$goalsCount goal${goalsCount == 1 ? '' : 's'}   •   $inProgressCount in progress',
                      style: const TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8B7D72),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandableCategoryCard extends StatelessWidget {
  final String category;
  final bool expanded;
  final List<GoalModel> goals;
  final VoidCallback onCategoryTap;
  final ValueChanged<GoalModel> onGoalTap;
  final ValueChanged<GoalModel> onMore;

  const _ExpandableCategoryCard({
    required this.category,
    required this.expanded,
    required this.goals,
    required this.onCategoryTap,
    required this.onGoalTap,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final inProgress = goals.where((goal) {
      return goal.progress > 0 && goal.progress < 1;
    }).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4).withOpacity(.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onCategoryTap,
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                    _CategoryIconBubble(category: category),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              color: Color(0xFF241D18),
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${goals.length} goal${goals.length == 1 ? '' : 's'}   •   $inProgress in progress',
                            style: const TextStyle(
                              color: Color(0xFF6F6258),
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.chevron_right_rounded,
                      color: const Color(0xFF8B7D72),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
            if (expanded && goals.isNotEmpty)
              ...goals.map(
                (goal) {
                  return _GoalListTile(
                    goal: goal,
                    onTap: () {
                      onGoalTap(goal);
                    },
                    onMore: () {
                      onMore(goal);
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _GoalListTile extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback onTap;
  final VoidCallback onMore;

  const _GoalListTile({
    required this.goal,
    required this.onTap,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (goal.progress * 100).round();

    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 13),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF4EFE8).withOpacity(.72),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFFE2D8CD),
              width: .7,
            ),
          ),
          child: Row(
            children: [
              _SmallProgressRing(progress: goal.progress),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF241D18),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (goal.subtitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        goal.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF6F6258),
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      '$percent%',
                      style: const TextStyle(
                        color: Color(0xFF8B7D72),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onMore,
                child: const Icon(
                  Icons.more_horiz_rounded,
                  color: Color(0xFF8B7D72),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryIconBubble extends StatelessWidget {
  final String category;

  const _CategoryIconBubble({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: _categoryColor(category),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _categoryIcon(category),
        color: const Color(0xFF7B6049),
        size: 20,
      ),
    );
  }

  static Color _categoryColor(String category) {
    switch (category) {
      case 'Wellness':
        return const Color(0xFFE8DFEA);
      case 'Beauty':
        return const Color(0xFFF2DFCF);
      case 'School':
        return const Color(0xFFE1E5EC);
      case 'Money':
        return const Color(0xFFE2E8DC);
      case 'Business':
        return const Color(0xFFE8DED5);
      case 'Family':
        return const Color(0xFFF0E0D6);
      case 'Spiritual':
        return const Color(0xFFE8DFD4);
      case 'Long-Term Vision':
        return const Color(0xFFECE1D3);
      case 'Daily Focus':
      default:
        return const Color(0xFFF0DCD5);
    }
  }

  static IconData _categoryIcon(String category) {
    switch (category) {
      case 'Wellness':
        return Icons.spa_outlined;
      case 'Beauty':
        return Icons.auto_awesome_outlined;
      case 'School':
        return Icons.school_outlined;
      case 'Money':
        return Icons.account_balance_wallet_outlined;
      case 'Business':
        return Icons.business_center_outlined;
      case 'Family':
        return Icons.family_restroom_rounded;
      case 'Spiritual':
        return Icons.wb_sunny_outlined;
      case 'Long-Term Vision':
        return Icons.lightbulb_outline_rounded;
      case 'Daily Focus':
      default:
        return Icons.favorite_border_rounded;
    }
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool dark;

  const _CircleIconButton({
    required this.icon,
    this.onTap,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF241D18) : const Color(0xFFFBF8F4),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
          boxShadow: [
            if (dark)
              BoxShadow(
                color: Colors.black.withOpacity(.12),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Icon(
          icon,
          color: dark ? const Color(0xFFFFF9F1) : const Color(0xFF241D18),
          size: 22,
        ),
      ),
    );
  }
}

class _SmallProgressRing extends StatelessWidget {
  final double progress;

  const _SmallProgressRing({
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return SizedBox(
      height: 54,
      width: 54,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: const Color(0xFFE7DDD4),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFFC6A06B),
            ),
          ),
          Text(
            '$percent%',
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _LargeProgressRing extends StatelessWidget {
  final double progress;
  final double size;

  const _LargeProgressRing({
    required this.progress,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 7,
            backgroundColor: const Color(0xFFE7DDD4),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFFC6A06B),
            ),
          ),
          Text(
            '$percent%',
            style: TextStyle(
              color: const Color(0xFF241D18),
              fontSize: size * .19,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCard extends StatelessWidget {
  final Widget child;

  const _SoftCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: child,
    );
  }
}

class _SoftTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final int maxLines;

  const _SoftTextField({
    required this.controller,
    required this.hintText,
    required this.minLines,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: const Color(0xFF8B6F55),
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF9A8D83),
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        filled: true,
        fillColor: const Color(0xFFFBF8F4).withOpacity(.92),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFC6A06B),
            width: .9,
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class _PillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PillChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF241D18) : const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xFF241D18) : const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFFFFF9F1) : const Color(0xFF6F6258),
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class _DetailActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DetailActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4).withOpacity(.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF8B6F55),
              size: 19,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressHistoryTile extends StatelessWidget {
  final int percent;
  final String label;

  const _ProgressHistoryTile({
    required this.percent,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 7,
              width: 7,
              decoration: const BoxDecoration(
                color: Color(0xFFC6A06B),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 34,
              width: 1,
              color: const Color(0xFFE2D8CD),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReminderRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _ReminderRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _SoftCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: const Color(0xFF8B6F55),
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionSheetItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  const _ActionSheetItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        destructive ? const Color(0xFFD96161) : const Color(0xFF241D18);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE2D8CD),
              width: .6,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
