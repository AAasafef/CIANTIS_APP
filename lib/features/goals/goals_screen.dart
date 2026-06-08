import 'package:flutter/material.dart';

import '../../models/goal_model.dart';
import '../../services/goals_service.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
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
    final allGoals = GoalsService.instance.goals;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                totalGoals: allGoals.length,
                onAddTap: () {
                  _showAddGoalDialog(context);
                },
              ),

              const SizedBox(height: 28),

              _CleanSlateHero(
                totalGoals: allGoals.length,
                onAddTap: () {
                  _showAddGoalDialog(context);
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Goal Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.4,
                  color: Color(0xFF241D18),
                ),
              ),

              const SizedBox(height: 14),

              ...categories.map((category) {
                final goals = GoalsService.instance.getGoalsByCategory(
                  category,
                );

                return _CategorySection(
                  category: category,
                  goals: goals,
                  onAddTap: () {
                    _showAddGoalDialog(
                      context,
                      startingCategory: category,
                    );
                  },
                  onEditGoal: (goal) {
                    _showEditGoalDialog(context, goal);
                  },
                  onDeleteGoal: (goal) {
                    GoalsService.instance.deleteGoal(goal.id);
                    setState(() {});
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddGoalDialog(
    BuildContext context, {
    String startingCategory = 'Daily Focus',
  }) {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();

    String selectedCategory = startingCategory;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF8F4),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      blurRadius: 28,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Goal',
                        style: TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 26,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -.6,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Add a real goal when you are ready.',
                        style: TextStyle(
                          color: Color(0xFF6F6258),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 20),

                      _GoalTextField(
                        controller: titleController,
                        hintText: 'Goal title',
                        icon: Icons.flag_outlined,
                      ),

                      const SizedBox(height: 14),

                      _GoalTextField(
                        controller: subtitleController,
                        hintText: 'Notes or description',
                        icon: Icons.edit_outlined,
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Category',
                        style: TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          letterSpacing: .4,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: categories.map((category) {
                          final selected =
                              selectedCategory == category;

                          return _CategoryChip(
                            text: category,
                            selected: selected,
                            onTap: () {
                              setDialogState(() {
                                selectedCategory = category;
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: _SoftButton(
                              text: 'Cancel',
                              icon: Icons.close_rounded,
                              filled: false,
                              onTap: () {
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _SoftButton(
                              text: 'Save',
                              icon: Icons.save_outlined,
                              filled: true,
                              onTap: () {
                                final title =
                                    titleController.text.trim();
                                final subtitle =
                                    subtitleController.text.trim();

                                if (title.isEmpty) {
                                  return;
                                }

                                GoalsService.instance.addGoal(
                                  GoalModel(
                                    id: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    title: title,
                                    subtitle: subtitle,
                                    progress: .0,
                                    category: selectedCategory,
                                  ),
                                );

                                Navigator.pop(dialogContext);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditGoalDialog(
    BuildContext context,
    GoalModel goal,
  ) {
    final titleController = TextEditingController(
      text: goal.title,
    );

    final subtitleController = TextEditingController(
      text: goal.subtitle,
    );

    String selectedCategory = goal.category;
    double progress = goal.progress;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF8F4),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      blurRadius: 28,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit Goal',
                        style: TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 26,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -.6,
                        ),
                      ),

                      const SizedBox(height: 18),

                      _GoalTextField(
                        controller: titleController,
                        hintText: 'Goal title',
                        icon: Icons.flag_outlined,
                      ),

                      const SizedBox(height: 14),

                      _GoalTextField(
                        controller: subtitleController,
                        hintText: 'Notes or description',
                        icon: Icons.edit_outlined,
                      ),

                      const SizedBox(height: 18),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: categories.map((category) {
                          final selected =
                              selectedCategory == category;

                          return _CategoryChip(
                            text: category,
                            selected: selected,
                            onTap: () {
                              setDialogState(() {
                                selectedCategory = category;
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 22),

                      Text(
                        'Progress ${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFFC6A06B),
                          inactiveTrackColor: const Color(0xFFE2D8CD),
                          thumbColor: const Color(0xFF8B6F55),
                          overlayColor:
                              const Color(0xFFC6A06B).withOpacity(.15),
                        ),
                        child: Slider(
                          value: progress,
                          onChanged: (value) {
                            setDialogState(() {
                              progress = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: _SoftButton(
                              text: 'Cancel',
                              icon: Icons.close_rounded,
                              filled: false,
                              onTap: () {
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _SoftButton(
                              text: 'Update',
                              icon: Icons.save_outlined,
                              filled: true,
                              onTap: () {
                                final title =
                                    titleController.text.trim();
                                final subtitle =
                                    subtitleController.text.trim();

                                if (title.isEmpty) {
                                  return;
                                }

                                GoalsService.instance.updateGoal(
                                  goal.copyWith(
                                    title: title,
                                    subtitle: subtitle,
                                    category: selectedCategory,
                                    progress: progress,
                                  ),
                                );

                                Navigator.pop(dialogContext);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final int totalGoals;
  final VoidCallback onAddTap;

  const _Header({
    required this.totalGoals,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals',
                style: TextStyle(
                  fontSize: 48,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.6,
                  color: Color(0xFF241D18),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'GRID MENU',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3.2,
                  color: Color(0xFF8B7D72),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F4).withOpacity(.92),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .7,
              ),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Color(0xFF241D18),
              size: 23,
            ),
          ),
        ),
      ],
    );
  }
}

class _CleanSlateHero extends StatelessWidget {
  final int totalGoals;
  final VoidCallback onAddTap;

  const _CleanSlateHero({
    required this.totalGoals,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasGoals = totalGoals > 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.92),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR REAL LIFE GOALS',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.4,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            hasGoals ? '$totalGoals saved goals' : 'Clean slate',
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 30,
              fontWeight: FontWeight.w300,
              letterSpacing: -.7,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            hasGoals
                ? 'Your goals are organized by category below.'
                : 'No fake entries. Add only the goals you actually want to track.',
            style: const TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 18),

          GestureDetector(
            onTap: onAddTap,
            child: const Text(
              'Create First Goal',
              style: TextStyle(
                color: Color(0xFFC6A06B),
                fontSize: 11,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String category;
  final List<GoalModel> goals;
  final VoidCallback onAddTap;
  final ValueChanged<GoalModel> onEditGoal;
  final ValueChanged<GoalModel> onDeleteGoal;

  const _CategorySection({
    required this.category,
    required this.goals,
    required this.onAddTap,
    required this.onEditGoal,
    required this.onDeleteGoal,
  });

  @override
  Widget build(BuildContext context) {
    final hasGoals = goals.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E6DB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _categoryIcon(category),
                    color: const Color(0xFF8B6F55),
                    size: 21,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -.2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        hasGoals
                            ? '${goals.length} goal${goals.length == 1 ? '' : 's'}'
                            : 'No goals yet',
                        style: const TextStyle(
                          color: Color(0xFF6F6258),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: onAddTap,
                  child: const Icon(
                    Icons.add_rounded,
                    color: Color(0xFF9A8D83),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),

          if (hasGoals)
            ...goals.map(
              (goal) => _GoalTile(
                goal: goal,
                onEdit: () {
                  onEditGoal(goal);
                },
                onDelete: () {
                  onDeleteGoal(goal);
                },
              ),
            ),
        ],
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Wellness':
        return Icons.favorite_border_rounded;
      case 'Beauty':
        return Icons.spa_outlined;
      case 'School':
        return Icons.school_outlined;
      case 'Money':
        return Icons.account_balance_wallet_outlined;
      case 'Business':
        return Icons.work_outline_rounded;
      case 'Family':
        return Icons.family_restroom_rounded;
      case 'Spiritual':
        return Icons.auto_awesome_outlined;
      case 'Long-Term Vision':
        return Icons.visibility_outlined;
      case 'Daily Focus':
      default:
        return Icons.flag_outlined;
    }
  }
}

class _GoalTile extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _GoalTile({
    required this.goal,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (goal.progress * 100).toInt();

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFE8).withOpacity(.72),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .6,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 42,
            width: 42,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: goal.progress,
                  strokeWidth: 3,
                  backgroundColor: const Color(0xFFE2D8CD),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFC6A06B),
                  ),
                ),
                Text(
                  '$percent%',
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.1,
                  ),
                ),
                if (goal.subtitle.trim().isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    goal.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: onEdit,
            child: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF8B7D72),
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Color(0xFF9A8D83),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  const _GoalTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF8B6F55),
          size: 20,
        ),
        filled: true,
        fillColor: const Color(0xFFF4EFE8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFFC6A06B),
            width: .9,
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF241D18)
              : const Color(0xFFF4EFE8),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xFF241D18)
                : const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected
                ? const Color(0xFFFFF9F1)
                : const Color(0xFF6F6258),
            fontSize: 11,
            fontWeight: FontWeight.w300,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }
}

class _SoftButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const _SoftButton({
    required this.text,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled
              ? const Color(0xFF241D18)
              : const Color(0xFFF4EFE8),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: filled
                ? const Color(0xFF241D18)
                : const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: filled
                  ? const Color(0xFFFFF9F1)
                  : const Color(0xFF8B6F55),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: filled
                    ? const Color(0xFFFFF9F1)
                    : const Color(0xFF241D18),
                fontSize: 12,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}