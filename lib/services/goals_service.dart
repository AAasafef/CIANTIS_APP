import '../models/goal_model.dart';

class GoalsService {
  static final GoalsService instance = GoalsService._internal();

  GoalsService._internal();

  final List<GoalModel> _goals = [];

  List<GoalModel> get goals => [..._goals];

  List<GoalModel> getGoals() {
    return [..._goals];
  }

  List<GoalModel> getGoalsByCategory(String category) {
    return _goals.where((goal) {
      return goal.category == category;
    }).toList();
  }

  void addGoal(GoalModel goal) {
    _goals.add(goal);
  }

  void updateGoal(GoalModel updatedGoal) {
    final index = _goals.indexWhere((goal) {
      return goal.id == updatedGoal.id;
    });

    if (index != -1) {
      _goals[index] = updatedGoal;
    }
  }

  void deleteGoal(String id) {
    _goals.removeWhere((goal) {
      return goal.id == id;
    });
  }
}