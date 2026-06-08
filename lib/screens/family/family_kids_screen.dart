import 'package:flutter/material.dart';

class FamilyKidsScreen extends StatefulWidget {
  const FamilyKidsScreen({super.key});

  @override
  State<FamilyKidsScreen> createState() =>
      _FamilyKidsScreenState();
}

class _FamilyKidsScreenState
    extends State<FamilyKidsScreen> {
  String selectedCategory = 'Dashboard';
  String selectedSubCategory = 'All';

  final List<Map<String, String>> children = [];
  final List<Map<String, String>> learningGoals = [];

  final Map<String, double> learningProgress = {
    'Reading': 0,
    'Math': 0,
    'Science': 0,
    'Writing': 0,
  };

  final Map<String, List<String>> drawerTabs = {
    'Dashboard': [],
    'Child Profiles': [
      'All Children',
      'Add Child',
      'School Info',
      'Emergency Info',
      'Important Notes',
    ],
    'Learning': [
      'Reading',
      'Math',
      'Science',
      'Writing',
      'Worksheets',
      'Progress Tracker',
    ],
    'Schedules': [
      'Morning Routine',
      'Bedtime Routine',
      'School Schedule',
      'Chores',
      'Appointments',
    ],
    'Health': [
      'Medical',
      'Dental',
      'Vision',
      'Medications',
      'Immunizations',
    ],
    'Documents': [
      'Birth Certificates',
      'School Forms',
      'Medical Papers',
      'Report Cards',
      'Legal Papers',
    ],
    'Activities': [
      'Sports',
      'Clubs',
      'Events',
      'Field Trips',
      'Birthdays',
    ],
    'Behavior & Rewards': [
      'Behavior Notes',
      'Reward Chart',
      'Goals',
      'Praise Log',
      'Consequences',
    ],
    'Family Budget': [
      'Clothing',
      'School Supplies',
      'Food & Snacks',
      'Activities',
      'Allowance',
    ],
    'Settings': [
      'Security',
      'Notifications',
      'Child Profile Settings',
      'Export',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawerEnableOpenDragGesture: true,
      drawer: _familyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2D241D),
        elevation: 0,
        onPressed: () {
          if (selectedCategory == 'Child Profiles') {
            _showChildFormSheet();
          } else if (selectedCategory == 'Learning') {
            _showLearningGoalSheet();
          } else {
            _showAddSheet();
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(20, 20, 20, 140),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
                        Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                margin:
                                    const EdgeInsets.only(right: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.menu_rounded,
                                  color: Color(0xFF2D241D),
                                ),
                              ),
                            );
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Family & Kids',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1,
                              color: Color(0xFF2D241D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Organize child profiles, learning, schedules, health, documents, activities, behavior, and family planning.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.58),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _heroCard(),
                    const SizedBox(height: 24),
                    _sectionHeader(),
                    const SizedBox(height: 16),
                    _selectedPanel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedSubCategory == 'All'
                ? selectedCategory
                : '$selectedCategory / $selectedSubCategory',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D241D),
            ),
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_right_rounded,
          color: Color(0xFFB08D6D),
        ),
      ],
    );
  }

  Widget _heroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFE7D8C8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFA06E55),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.family_restroom_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Family command center',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D241D),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Swipe from the left or tap the menu to move through each family area.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: Color(0xFF6F6258),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectedPanel() {
    if (selectedCategory == 'Dashboard') {
      return _dashboardPanel();
    }

    if (selectedCategory == 'Child Profiles') {
      return _childProfilesPanel();
    }

    if (selectedCategory == 'Learning') {
      return _learningPanel();
    }

    if (selectedCategory == 'Settings') {
      return _settingsPanel();
    }

    return _genericPanel();
  }

  Widget _dashboardPanel() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _statCard(
                title: 'Children',
                value: '${children.length}',
                icon: Icons.child_care_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                title: 'Learning Goals',
                value: '${learningGoals.length}',
                icon: Icons.menu_book_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _dashboardCard(
          icon: Icons.child_care_outlined,
          title: 'Child Profiles',
          subtitle:
              'Create individual profiles and connect school, health, notes, and documents later.',
          onTap: () {
            setState(() {
              selectedCategory = 'Child Profiles';
              selectedSubCategory = 'All';
            });
          },
        ),
        _dashboardCard(
          icon: Icons.menu_book_outlined,
          title: 'Learning Tracker',
          subtitle:
              'Keep reading, math, science, writing, worksheets, and progress organized.',
          onTap: () {
            setState(() {
              selectedCategory = 'Learning';
              selectedSubCategory = 'All';
            });
          },
        ),
        _dashboardCard(
          icon: Icons.calendar_month_outlined,
          title: 'Family Schedule',
          subtitle:
              'Track routines, school schedules, chores, appointments, and events.',
          onTap: () {
            setState(() {
              selectedCategory = 'Schedules';
              selectedSubCategory = 'All';
            });
          },
        ),
        _dashboardCard(
          icon: Icons.folder_copy_outlined,
          title: 'Family Documents',
          subtitle:
              'Store birth certificates, school forms, report cards, medical papers, and legal papers.',
          onTap: () {
            setState(() {
              selectedCategory = 'Documents';
              selectedSubCategory = 'All';
            });
          },
        ),
      ],
    );
  }

  Widget _childProfilesPanel() {
    if (selectedSubCategory == 'Add Child') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            selectedSubCategory = 'All';
          });
          _showChildFormSheet();
        }
      });
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Child Profiles',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF2D241D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                children.isEmpty
                    ? 'Add each child profile when you are ready. No personal information is hardcoded.'
                    : 'Manage child profiles, school details, emergency information, and notes.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: Colors.black.withOpacity(.58),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _showChildFormSheet();
                },
                child: Container(
                  height: 54,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D241D),
                    borderRadius:
                        BorderRadius.circular(22),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Child Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (children.isEmpty)
          _emptyChildState()
        else
          ...children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;

            return _childCard(
              index: index,
              child: child,
            );
          }),
      ],
    );
  }

  Widget _learningPanel() {
    if (selectedSubCategory != 'All' &&
        learningProgress.containsKey(selectedSubCategory)) {
      return _singleLearningSubjectPanel(selectedSubCategory);
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Learning Tracker',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF2D241D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track reading, math, science, writing, worksheets, and progress goals.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: Colors.black.withOpacity(.58),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _showLearningGoalSheet();
                },
                child: Container(
                  height: 54,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D241D),
                    borderRadius:
                        BorderRadius.circular(22),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Learning Goal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _progressCard(
          title: 'Reading',
          progress: learningProgress['Reading'] ?? 0,
          icon: Icons.menu_book_outlined,
        ),
        _progressCard(
          title: 'Math',
          progress: learningProgress['Math'] ?? 0,
          icon: Icons.calculate_outlined,
        ),
        _progressCard(
          title: 'Science',
          progress: learningProgress['Science'] ?? 0,
          icon: Icons.science_outlined,
        ),
        _progressCard(
          title: 'Writing',
          progress: learningProgress['Writing'] ?? 0,
          icon: Icons.edit_note_outlined,
        ),
        const SizedBox(height: 2),
        if (learningGoals.isEmpty)
          _emptyLearningState()
        else
          ...learningGoals.asMap().entries.map((entry) {
            return _learningGoalCard(
              index: entry.key,
              goal: entry.value,
            );
          }),
      ],
    );
  }

  Widget _singleLearningSubjectPanel(String subject) {
    final relatedGoals = learningGoals
        .asMap()
        .entries
        .where((entry) => entry.value['subject'] == subject)
        .toList();

    return Column(
      children: [
        _progressCard(
          title: subject,
          progress: learningProgress[subject] ?? 0,
          icon: _learningIcon(subject),
        ),
        if (relatedGoals.isEmpty)
          _emptySubjectState(subject)
        else
          ...relatedGoals.map((entry) {
            return _learningGoalCard(
              index: entry.key,
              goal: entry.value,
            );
          }),
      ],
    );
  }

  Widget _emptyLearningState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE7D8C8),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.menu_book_outlined,
              color: Color(0xFF8B735F),
              size: 34,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No learning goals yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap Add Learning Goal to start tracking reading, math, science, or writing.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.black.withOpacity(.55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptySubjectState(String subject) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(
            _learningIcon(subject),
            color: const Color(0xFF8B735F),
            size: 36,
          ),
          const SizedBox(height: 14),
          Text(
            'No $subject goals yet',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Goals connected to $subject will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.black.withOpacity(.55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard({
    required String title,
    required double progress,
    required IconData icon,
  }) {
    final percent = (progress * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F3EC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF8B735F),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D241D),
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF8B735F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: const Color(0xFFEDE6DE),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFFB08D6D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _learningGoalCard({
    required int index,
    required Map<String, String> goal,
  }) {
    final title = goal['title'] ?? 'Untitled Goal';
    final subject = goal['subject'] ?? 'Reading';
    final child = goal['child'] ?? '';
    final notes = goal['notes'] ?? '';
    final progress =
        double.tryParse(goal['progress'] ?? '0') ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F3EC),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  _learningIcon(subject),
                  color: const Color(0xFF8B735F),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.isEmpty
                          ? 'Untitled Goal'
                          : title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      child.isEmpty
                          ? subject
                          : '$subject • $child',
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.black.withOpacity(.55),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: Color(0xFF8B735F),
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    _showLearningGoalSheet(
                      index: index,
                      existingGoal: goal,
                    );
                  }

                  if (value == 'delete') {
                    _deleteLearningGoal(index);
                  }
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFEDE6DE),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFFB08D6D),
              ),
            ),
          ),
          if (notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              notes,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: Colors.black.withOpacity(.58),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _emptyChildState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE7D8C8),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.child_care_outlined,
              color: Color(0xFF8B735F),
              size: 34,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No child profiles yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap Add Child Profile to create the first blank profile.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.black.withOpacity(.55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _childCard({
    required int index,
    required Map<String, String> child,
  }) {
    final name = child['name'] ?? 'Unnamed Child';
    final grade = child['grade'] ?? '';
    final school = child['school'] ?? '';
    final notes = child['notes'] ?? '';
    final emergency = child['emergency'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F3EC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF8B735F),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty
                          ? 'Unnamed Child'
                          : name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      grade.isEmpty && school.isEmpty
                          ? 'Profile details can be added anytime.'
                          : [
                              if (grade.isNotEmpty) grade,
                              if (school.isNotEmpty) school,
                            ].join(' • '),
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.black.withOpacity(.55),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: Color(0xFF8B735F),
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    _showChildFormSheet(
                      index: index,
                      existingChild: child,
                    );
                  }

                  if (value == 'delete') {
                    _deleteChild(index);
                  }
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
              ),
            ],
          ),
          if (emergency.isNotEmpty ||
              notes.isNotEmpty) ...[
            const SizedBox(height: 16),
            if (emergency.isNotEmpty)
              _childDetailRow(
                icon: Icons.emergency_outlined,
                title: 'Emergency',
                value: emergency,
              ),
            if (notes.isNotEmpty)
              _childDetailRow(
                icon: Icons.notes_outlined,
                title: 'Notes',
                value: notes,
              ),
          ],
        ],
      ),
    );
  }

  Widget _childDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF8B735F),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black.withOpacity(.58),
                ),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D241D),
                    ),
                  ),
                  TextSpan(
                    text: value,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genericPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            selectedCategory,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedSubCategory == 'All'
                ? 'This area is ready for saved family information, child records, notes, trackers, and tools.'
                : '$selectedSubCategory tools, records, notes, and saved items will appear here.',
            style: TextStyle(
              fontSize: 14,
              height: 1.55,
              color: Colors.black.withOpacity(.58),
            ),
          ),
          const SizedBox(height: 22),
          _placeholderTile(
            icon: Icons.add_circle_outline,
            title: 'Add Information',
            subtitle:
                'Add child details, notes, records, reminders, or documents later.',
          ),
          _placeholderTile(
            icon: Icons.folder_open_outlined,
            title: 'View Saved Items',
            subtitle:
                'Saved family information for this section will appear here.',
          ),
          _placeholderTile(
            icon: Icons.auto_awesome_outlined,
            title: 'AI Help',
            subtitle:
                'Future AI can summarize records, build routines, or organize child information.',
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF8B735F),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6F6258),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F3EC),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF8B735F),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF2D241D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color:
                          Colors.black.withOpacity(.55),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _familyDrawer() {
    return Drawer(
      backgroundColor:
          const Color(0xFF5B5149).withOpacity(.96),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(22, 28, 22, 22),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  Container(
                    height: 74,
                    width: 74,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA06E55),
                      borderRadius:
                          BorderRadius.circular(38),
                    ),
                    child: const Icon(
                      Icons.family_restroom_outlined,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Family',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'KIDS SPACE',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              ...drawerTabs.entries.map((entry) {
                final title = entry.key;
                final children = entry.value;

                if (children.isEmpty) {
                  return _drawerMainTab(title);
                }

                return _drawerExpandableTab(
                  title: title,
                  children: children,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerMainTab(String title) {
    final isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);

        setState(() {
          selectedCategory = title;
          selectedSubCategory = 'All';
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(.18)
              : Colors.white.withOpacity(.10),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _drawerExpandableTab({
    required String title,
    required List<String> children,
  }) {
    final isSelected = selectedCategory == title;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withOpacity(.18)
            : Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 4,
          ),
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w300,
            ),
          ),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);

                setState(() {
                  selectedCategory = title;
                  selectedSubCategory = 'All';
                });
              },
              child: _drawerSubTab('All'),
            ),
            ...children.map((sub) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    selectedCategory = title;
                    selectedSubCategory = sub;
                  });
                },
                child: _drawerSubTab(sub),
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _drawerSubTab(String title) {
    final isSelected = selectedSubCategory == title;

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.fromLTRB(18, 0, 18, 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withOpacity(.18)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _settingsPanel() {
    final settings = [
      [
        'Security',
        'Lock family records and private child information.',
      ],
      [
        'Notifications',
        'Reminders for school, health, routines, chores, and activities.',
      ],
      [
        'Child Profile Settings',
        'Customize what each child profile can store later.',
      ],
      [
        'Export',
        'Export family data by child, category, or date range.',
      ],
    ];

    return Column(
      children: settings.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      item[0],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item[1],
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.black.withOpacity(.55),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFFB08D6D),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _placeholderTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF8B735F),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D241D),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(.55),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChildFormSheet({
    int? index,
    Map<String, String>? existingChild,
  }) {
    final nameController = TextEditingController(
      text: existingChild?['name'] ?? '',
    );
    final gradeController = TextEditingController(
      text: existingChild?['grade'] ?? '',
    );
    final schoolController = TextEditingController(
      text: existingChild?['school'] ?? '',
    );
    final emergencyController = TextEditingController(
      text: existingChild?['emergency'] ?? '',
    );
    final notesController = TextEditingController(
      text: existingChild?['notes'] ?? '',
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F3EC),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(34),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == null
                          ? 'Add Child Profile'
                          : 'Edit Child Profile',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Add only the details you want. You can edit this later.',
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            Colors.black.withOpacity(.58),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _formField(
                      controller: nameController,
                      label: 'Child Name',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 14),
                    _formField(
                      controller: gradeController,
                      label: 'Grade / Level',
                      icon: Icons.school_outlined,
                    ),
                    const SizedBox(height: 14),
                    _formField(
                      controller: schoolController,
                      label: 'School',
                      icon: Icons.apartment_outlined,
                    ),
                    const SizedBox(height: 14),
                    _formField(
                      controller: emergencyController,
                      label: 'Emergency Info',
                      icon: Icons.emergency_outlined,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    _formField(
                      controller: notesController,
                      label: 'Notes',
                      icon: Icons.notes_outlined,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        final child = {
                          'name':
                              nameController.text.trim(),
                          'grade':
                              gradeController.text.trim(),
                          'school':
                              schoolController.text.trim(),
                          'emergency': emergencyController
                              .text
                              .trim(),
                          'notes':
                              notesController.text.trim(),
                        };

                        setState(() {
                          if (index == null) {
                            children.add(child);
                          } else {
                            children[index] = child;
                          }

                          selectedCategory =
                              'Child Profiles';
                          selectedSubCategory = 'All';
                        });

                        Navigator.pop(sheetContext);
                      },
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF2D241D),
                          borderRadius:
                              BorderRadius.circular(22),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          index == null
                              ? 'Save Profile'
                              : 'Update Profile',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLearningGoalSheet({
    int? index,
    Map<String, String>? existingGoal,
  }) {
    final titleController = TextEditingController(
      text: existingGoal?['title'] ?? '',
    );
    final childController = TextEditingController(
      text: existingGoal?['child'] ?? '',
    );
    final notesController = TextEditingController(
      text: existingGoal?['notes'] ?? '',
    );

    String selectedSubject =
        existingGoal?['subject'] ?? 'Reading';

    double selectedProgress = double.tryParse(
          existingGoal?['progress'] ?? '0',
        ) ??
        0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, sheetSetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext)
                    .viewInsets
                    .bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F3EC),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          index == null
                              ? 'Add Learning Goal'
                              : 'Edit Learning Goal',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF2D241D),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Create a learning goal and track progress over time.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                                .withOpacity(.58),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _formField(
                          controller: titleController,
                          label: 'Goal Title',
                          icon: Icons.flag_outlined,
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: childController,
                          label: 'Child Name / Profile',
                          icon: Icons.child_care_outlined,
                        ),
                        const SizedBox(height: 14),
                        _subjectPicker(
                          selectedSubject: selectedSubject,
                          onSelected: (value) {
                            sheetSetState(() {
                              selectedSubject = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Progress: ${(selectedProgress * 100).round()}%',
                          style: const TextStyle(
                            color: Color(0xFF2D241D),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Slider(
                          value: selectedProgress,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          activeColor:
                              const Color(0xFFB08D6D),
                          inactiveColor:
                              const Color(0xFFE7D8C8),
                          onChanged: (value) {
                            sheetSetState(() {
                              selectedProgress = value;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        _formField(
                          controller: notesController,
                          label: 'Notes',
                          icon: Icons.notes_outlined,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            final goal = {
                              'title':
                                  titleController.text.trim(),
                              'child':
                                  childController.text.trim(),
                              'subject': selectedSubject,
                              'progress':
                                  selectedProgress.toString(),
                              'notes':
                                  notesController.text.trim(),
                            };

                            setState(() {
                              if (index == null) {
                                learningGoals.add(goal);
                              } else {
                                learningGoals[index] = goal;
                              }

                              _recalculateLearningProgress();

                              selectedCategory = 'Learning';
                              selectedSubCategory = 'All';
                            });

                            Navigator.pop(sheetContext);
                          },
                          child: Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF2D241D),
                              borderRadius:
                                  BorderRadius.circular(22),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              index == null
                                  ? 'Save Goal'
                                  : 'Update Goal',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _subjectPicker({
    required String selectedSubject,
    required ValueChanged<String> onSelected,
  }) {
    final subjects = [
      'Reading',
      'Math',
      'Science',
      'Writing',
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: subjects.map((subject) {
        final selected = selectedSubject == subject;

        return GestureDetector(
          onTap: () {
            onSelected(subject);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF2D241D)
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              subject,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : const Color(0xFF2D241D),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _formField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF8B735F),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF6F6258),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(
            color: Color(0xFFB08D6D),
          ),
        ),
      ),
    );
  }

  IconData _learningIcon(String subject) {
    switch (subject) {
      case 'Math':
        return Icons.calculate_outlined;
      case 'Science':
        return Icons.science_outlined;
      case 'Writing':
        return Icons.edit_note_outlined;
      case 'Reading':
      default:
        return Icons.menu_book_outlined;
    }
  }

  void _recalculateLearningProgress() {
    for (final subject in learningProgress.keys) {
      final subjectGoals = learningGoals
          .where((goal) => goal['subject'] == subject)
          .toList();

      if (subjectGoals.isEmpty) {
        learningProgress[subject] = 0;
      } else {
        final total = subjectGoals.fold<double>(
          0,
          (sum, goal) {
            return sum +
                (double.tryParse(goal['progress'] ?? '0') ??
                    0);
          },
        );

        learningProgress[subject] =
            total / subjectGoals.length;
      }
    }
  }

  void _deleteChild(int index) {
    setState(() {
      children.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF2D241D),
        content: Text('Child profile deleted.'),
      ),
    );
  }

  void _deleteLearningGoal(int index) {
    setState(() {
      learningGoals.removeAt(index);
      _recalculateLearningProgress();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF2D241D),
        content: Text('Learning goal deleted.'),
      ),
    );
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F3EC),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(34),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add to Family Space',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF2D241D),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Choose what you want to add.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(.58),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),
                _addOption(
                  icon: Icons.child_care_outlined,
                  title: 'Child Profile',
                  subtitle: 'Create a child profile',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showChildFormSheet();
                  },
                ),
                const SizedBox(height: 16),
                _addOption(
                  icon: Icons.menu_book_outlined,
                  title: 'Learning Goal',
                  subtitle: 'Track reading, math, science, or writing',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showLearningGoalSheet();
                  },
                ),
                const SizedBox(height: 16),
                _addOption(
                  icon: Icons.note_add_outlined,
                  title: 'Family Note',
                  subtitle:
                      'Save reminders, behavior notes, or details',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showComingSoon('Family note');
                  },
                ),
                const SizedBox(height: 16),
                _addOption(
                  icon: Icons.folder_copy_outlined,
                  title: 'Family Document',
                  subtitle:
                      'Attach school, health, or legal documents',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showComingSoon('Family document');
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(18),
                  color: const Color(0xFFF4EFE8),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF6E5846),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.black.withOpacity(.55),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFFB08D6D),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2D241D),
        content: Text(
          '$item placeholder ready. Real saving comes later.',
        ),
      ),
    );
  }
}