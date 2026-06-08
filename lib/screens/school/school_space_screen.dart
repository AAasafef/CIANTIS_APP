import 'package:flutter/material.dart';

import 'school_documents_screen.dart';
import '../notes/notes_screen.dart';

class SchoolSpaceScreen extends StatefulWidget {
  const SchoolSpaceScreen({super.key});

  @override
  State<SchoolSpaceScreen> createState() => _SchoolSpaceScreenState();
}

class _SchoolSpaceScreenState extends State<SchoolSpaceScreen> {
  final Color bg = const Color(0xFFF8F2EA);
  final Color ink = const Color(0xFF211815);
  final Color softInk = const Color(0xFF76665A);
  final Color cream = const Color(0xFFFFFCF7);
  final Color blush = const Color(0xFFF4D9D6);
  final Color rose = const Color(0xFFB13D6F);
  final Color brown = const Color(0xFF2A1711);

  int _tab = 1;

  final List<_SchoolTool> tools = const [
    _SchoolTool('Assignments', 'Due dates', Icons.assignment_outlined, Color(0xFFF5D9D8)),
    _SchoolTool('Classes', 'Subjects', Icons.school_outlined, Color(0xFFF7E2CA)),
    _SchoolTool('Calendar', 'School dates', Icons.calendar_month_outlined, Color(0xFFF4DFCF)),
    _SchoolTool('Notes', 'Study notes', Icons.edit_note_outlined, Color(0xFFE2E9D9)),
    _SchoolTool('Flashcards', 'Practice', Icons.style_outlined, Color(0xFFDDE7D8)),
    _SchoolTool('Quizzes', 'Test yourself', Icons.quiz_outlined, Color(0xFFE6DDEB)),
    _SchoolTool('Grades', 'Scores', Icons.trending_up_outlined, Color(0xFFF2D8DC)),
    _SchoolTool('Documents', 'Files', Icons.folder_copy_outlined, Color(0xFFD8E1EF)),
    _SchoolTool('NCLEX', 'Prep', Icons.medical_services_outlined, Color(0xFFF1D7D4)),
    _SchoolTool('Planner', 'Study blocks', Icons.event_note_outlined, Color(0xFFE8E0F0)),
    _SchoolTool('Resources', 'Books + links', Icons.menu_book_outlined, Color(0xFFF1D7C0)),
    _SchoolTool('More', 'Settings', Icons.grid_view_rounded, Color(0xFFE6E0D6)),
  ];

  void _open(String title) {
    if (title == 'Notes') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const NotesScreen(
            spaceId: 'school',
            spaceName: 'School',
          ),
        ),
      );
      return;
    }

    if (title == 'Documents') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SchoolDocumentsScreen()),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _SchoolDetailShell(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(wide ? 34 : 18, 14, wide ? 34 : 18, 118),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _topBar(),
                  const SizedBox(height: 18),
                  _searchCard(),
                  const SizedBox(height: 18),
                  _toolGrid(wide),
                  const SizedBox(height: 26),
                  _focusCard(),
                  const SizedBox(height: 18),
                  _todaySchedule(),
                  const SizedBox(height: 18),
                  _progressOverview(),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: brown,
        foregroundColor: Colors.white,
        elevation: 7,
        shape: const CircleBorder(),
        onPressed: () => _open('Add Assignment'),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('School', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300, color: ink)),
              const SizedBox(height: 2),
              Text('LEARNING  •  FOCUS  •  SUCCESS', style: TextStyle(fontSize: 8, letterSpacing: 2, color: softInk)),
            ],
          ),
        ),
        IconButton(
          onPressed: () => _open('Reminders'),
          icon: Icon(Icons.notifications_none_rounded, color: ink, size: 21),
        ),
      ],
    );
  }

  Widget _searchCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hey Ciantis ✨', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ink)),
        const SizedBox(height: 3),
        Text('Let’s get things done today.', style: TextStyle(fontSize: 12, color: softInk)),
        const SizedBox(height: 14),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 8))],
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 18, color: softInk),
              const SizedBox(width: 8),
              Text('Search tools, classes, notes...', style: TextStyle(fontSize: 12, color: softInk)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toolGrid(bool wide) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tools.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: wide ? 6 : 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .86,
      ),
      itemBuilder: (_, i) {
        final t = tools[i];
        return GestureDetector(
          onTap: () => _open(t.title),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: t.color,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [BoxShadow(color: Color(0x0E000000), blurRadius: 14, offset: Offset(0, 7))],
                  ),
                  child: Center(child: Icon(t.icon, color: brown, size: 24)),
                ),
              ),
              const SizedBox(height: 6),
              Text(t.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: ink)),
            ],
          ),
        );
      },
    );
  }

  Widget _focusCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F0),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEEDDD0)),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: blush, child: Icon(Icons.auto_awesome_rounded, color: rose, size: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Text('You’re doing amazing, Ciantis. Keep showing up for your future self.', style: TextStyle(fontSize: 12, height: 1.35, color: ink)),
          ),
        ],
      ),
    );
  }

  Widget _todaySchedule() {
    final items = [
      ['8:00 AM', 'Pharmacology Lecture'],
      ['10:00 AM', 'Skills Lab'],
      ['1:00 PM', 'Study Session'],
      ['4:30 PM', 'ATI Practice'],
    ];

    return _sectionCard(
      title: 'Today’s Schedule',
      child: Column(
        children: items.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(width: 70, child: Text(e[0], style: TextStyle(fontSize: 11, color: softInk))),
                Expanded(child: Text(e[1], style: TextStyle(fontSize: 12, color: ink))),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _progressOverview() {
    final stats = [
      ['GPA', '3.75'],
      ['Course Load', '5'],
      ['Attendance', '94%'],
    ];

    return Row(
      children: stats.map((s) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Text(s[1], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: ink)),
                const SizedBox(height: 4),
                Text(s[0], style: TextStyle(fontSize: 10, color: softInk)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ink)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _bottomNav() {
    final items = [
      [Icons.dashboard_outlined, 'Spaces'],
      [Icons.school, 'School'],
      [Icons.auto_awesome_outlined, 'AI'],
      [Icons.settings_outlined, 'Settings'],
    ];

    return BottomAppBar(
      color: const Color(0xFFFFFCF7),
      elevation: 18,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length + 1, (i) {
            if (i == 2) return const SizedBox(width: 54);
            final index = i > 2 ? i - 1 : i;
            final selected = _tab == index;
            return GestureDetector(
              onTap: () {
                setState(() => _tab = index);
                if (index == 3) _open('School Settings');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[index][0] as IconData, size: 19, color: selected ? rose : softInk),
                  const SizedBox(height: 4),
                  Text(items[index][1] as String, style: TextStyle(fontSize: 9, color: selected ? rose : softInk)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _SchoolDetailShell extends StatelessWidget {
  final String title;

  const _SchoolDetailShell({required this.title});

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFF8F2EA);
    final ink = const Color(0xFF211815);
    final soft = const Color(0xFF76665A);
    final rose = const Color(0xFFB13D6F);
    final cream = const Color(0xFFFFFCF7);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 100),
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_rounded, color: ink)),
                Expanded(child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: ink))),
                Icon(Icons.notifications_none_rounded, size: 20, color: ink),
              ],
            ),
            const SizedBox(height: 14),
            if (title == 'Classes') _classSelector(),
            if (title == 'Assignments') _assignments(),
            if (title == 'Add Assignment') _addAssignment(rose, cream, ink, soft),
            if (title == 'Flashcards') _flashcards(ink, soft, cream),
            if (title == 'Quizzes') _quiz(rose, cream, ink),
            if (title == 'Grades') _quizResults(rose, cream, ink, soft),
            if (title == 'Planner') _studyPlanner(cream),
            if (title == 'Calendar') _calendarView(cream, ink),
            if (title == 'Reminders') _reminders(rose),
            if (title == 'School Settings') _settings(cream, ink, soft),
            if (title == 'NCLEX') _nclex(cream),
            if (![
              'Classes',
              'Assignments',
              'Add Assignment',
              'Flashcards',
              'Quizzes',
              'Grades',
              'Planner',
              'Calendar',
              'Reminders',
              'School Settings',
              'NCLEX',
            ].contains(title))
              _comingSoon(cream, soft),
          ],
        ),
      ),
    );
  }

  Widget _classSelector() {
    final classes = [
      ['Fundamentals of Nursing', 'NUR 101', const Color(0xFFF1C9CF)],
      ['Pharmacology', 'NUR 110', const Color(0xFFF7D9BE)],
      ['Anatomy & Physiology', 'BIO 205', const Color(0xFFDDE2D2)],
      ['Medical-Surgical Nursing', 'NUR 210', const Color(0xFFE1DDF0)],
      ['Pediatric Nursing', 'NUR 215', const Color(0xFFD7E8DC)],
      ['Psychology', 'PSY 101', const Color(0xFFF4DDC8)],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose a Class or Subject', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        const SizedBox(height: 18),
        ...classes.map((c) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: c[2] as Color, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                const Icon(Icons.local_library_outlined, size: 20, color: Color(0xFF2A1711)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c[0] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                    Text(c[1] as String, style: const TextStyle(fontSize: 10)),
                  ]),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _assignments() {
    final items = [
      ['Care Plan: COPD Patient', 'Med-Surg Nursing', '8 days left', const Color(0xFFF7DFD9)],
      ['Pharmacology Drug Card', 'Pharmacology', '6 days left', const Color(0xFFF7E5C9)],
      ['Anatomy Lab Report', 'Anatomy & Physiology', '12 days left', const Color(0xFFDDE8D8)],
      ['Research Paper', 'Psychology', '19 days left', const Color(0xFFE8DFF0)],
    ];

    return Column(
      children: [
        _pillTabs(),
        const SizedBox(height: 12),
        ...items.map((e) => _listTile(e[0] as String, e[1] as String, e[2] as String, e[3] as Color)),
      ],
    );
  }

  Widget _addAssignment(Color rose, Color cream, Color ink, Color soft) {
    return Column(
      children: [
        _field('Title', 'Ex: Care Plan', cream, soft),
        _field('Class', 'Select Class', cream, soft),
        Row(children: [
          Expanded(child: _field('Due Date', 'May 22, 2025', cream, soft)),
          const SizedBox(width: 10),
          Expanded(child: _field('Time', '11:59 PM', cream, soft)),
        ]),
        _field('Points', '100', cream, soft),
        _field('Notes', 'Add notes...', cream, soft, tall: true),
        const SizedBox(height: 18),
        _button('Create Assignment', rose),
      ],
    );
  }

  Widget _flashcards(Color ink, Color soft, Color cream) {
    return Column(
      children: [
        Container(
          height: 230,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 18, offset: Offset(0, 8))],
          ),
          child: Center(
            child: Text('What is the mechanism\nof action of\nLisinopril?', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, height: 1.3, color: ink)),
          ),
        ),
        const SizedBox(height: 18),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _round(Icons.close_rounded, const Color(0xFFF5C9C4)),
          Text('12 / 45', style: TextStyle(color: soft)),
          _round(Icons.check_rounded, const Color(0xFF91A47F)),
        ]),
        const SizedBox(height: 18),
        _button('+ New Deck', const Color(0xFFEFE7DF), dark: true),
      ],
    );
  }

  Widget _quiz(Color rose, Color cream, Color ink) {
    final answers = ['Hypoglycemia', 'Lactic acidosis', 'Hypertension', 'Hyperkalemia'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Which of the following is a side effect of Metformin?', style: TextStyle(fontSize: 22, height: 1.25, color: ink)),
        const SizedBox(height: 18),
        ...answers.asMap().entries.map((entry) {
          final selected = entry.key == 1;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFF1C8CF) : cream,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? rose : const Color(0xFFE9DED4)),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 12, backgroundColor: const Color(0xFFF5EEE7), child: Text(String.fromCharCode(65 + entry.key), style: const TextStyle(fontSize: 10))),
                const SizedBox(width: 10),
                Text(entry.value, style: TextStyle(fontSize: 13, color: ink)),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
        _button('Next', rose),
      ],
    );
  }

  Widget _quizResults(Color rose, Color cream, Color ink, Color soft) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircularProgressIndicator(value: .85, strokeWidth: 5, color: rose, backgroundColor: const Color(0xFFE8DDD4)),
                ),
                Column(children: [
                  Text('85%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: ink)),
                  Text('17 / 20 Correct', style: TextStyle(fontSize: 11, color: soft)),
                ]),
              ]),
              const SizedBox(height: 18),
              _resultRow('Correct', '17', Colors.green),
              _resultRow('Incorrect', '3', Colors.redAccent),
              _resultRow('Unanswered', '0', Colors.orange),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _button('Review Answers', rose),
      ],
    );
  }

  Widget _studyPlanner(Color cream) {
    final items = [
      ['Pharmacology', '9:00 AM - 10:30 AM'],
      ['Anatomy Review', '11:00 AM - 12:30 PM'],
      ['Lunch Break', '12:30 PM - 1:30 PM'],
      ['Skills Practice', '2:00 PM - 4:00 PM'],
    ];
    return Column(children: items.map((e) => _listTile(e[0], e[1], '', cream)).toList());
  }

  Widget _calendarView(Color cream, Color ink) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('May 2025', style: TextStyle(fontSize: 18, color: ink)),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 35,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemBuilder: (_, i) {
            final day = i + 1;
            final marked = day == 7 || day == 15 || day == 22;
            return Center(
              child: CircleAvatar(
                radius: 16,
                backgroundColor: marked ? const Color(0xFFE8BCC7) : Colors.transparent,
                child: Text('$day', style: TextStyle(fontSize: 11, color: ink)),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _listTile('Pharmacology Lecture', '8:00 AM · NUR 110', '', cream),
        _listTile('Skills Lab', '10:00 AM · Simulation Lab', '', cream),
        _listTile('Study Session', '1:00 PM · Library', '', cream),
      ],
    );
  }

  Widget _reminders(Color rose) {
    final reminders = [
      ['Pharmacology Exam', '2 days left'],
      ['ATI Practice Test', '4 days left'],
      ['Skills Lab Checkoff', '5 days left'],
      ['Care Plan Assignment', '8 days left'],
    ];
    return Column(children: [
      _pillTabs(),
      const SizedBox(height: 12),
      ...reminders.map((e) => _listTile(e[0], 'May 2025', e[1], const Color(0xFFFFEFEF))),
      const SizedBox(height: 16),
      _button('+ Add Reminder', rose),
    ]);
  }

  Widget _settings(Color cream, Color ink, Color soft) {
    final settings = [
      'Academic Profile',
      'School Information',
      'Term & Semester',
      'Notifications',
      'Reminders',
      'Study Preferences',
      'Privacy & Security',
      'Backup & Sync',
      'Appearance',
    ];

    return Column(
      children: settings.map((s) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            Icon(Icons.settings_outlined, size: 16, color: soft),
            const SizedBox(width: 10),
            Expanded(child: Text(s, style: TextStyle(fontSize: 13, color: ink))),
            Icon(Icons.chevron_right_rounded, color: soft),
          ]),
        );
      }).toList(),
    );
  }

  Widget _nclex(Color cream) {
    final items = [
      ['Practice Questions', '1,245 Questions'],
      ['Dosage Calculations', '120 Problems'],
      ['ATI Practice Tests', '6 Practice Exams'],
      ['Skills Checklists', '45 Checklists'],
      ['Question of the Day', 'New question daily'],
    ];
    return Column(children: items.map((e) => _listTile(e[0], e[1], '', cream)).toList());
  }

  Widget _comingSoon(Color cream, Color soft) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(18)),
      child: Text('This section is ready for the next build.', style: TextStyle(color: soft)),
    );
  }

  Widget _pillTabs() {
    return Row(children: [
      _pill('All', true),
      _pill('Upcoming', false),
      _pill('Completed', false),
    ]);
  }

  Widget _pill(String text, bool selected) {
    return Expanded(
      child: Container(
        height: 32,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(color: selected ? const Color(0xFF2A1711) : const Color(0xFFF1EAE3), borderRadius: BorderRadius.circular(14)),
        child: Center(child: Text(text, style: TextStyle(fontSize: 10, color: selected ? Colors.white : const Color(0xFF76665A)))),
      ),
    );
  }

  Widget _listTile(String title, String subtitle, String trailing, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, size: 18, color: Color(0xFFB13D6F)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              if (subtitle.isNotEmpty) Text(subtitle, style: const TextStyle(fontSize: 10, color: Color(0xFF76665A))),
            ]),
          ),
          if (trailing.isNotEmpty) Text(trailing, style: const TextStyle(fontSize: 10, color: Color(0xFFB13D6F))),
        ],
      ),
    );
  }

  Widget _field(String label, String hint, Color cream, Color soft, {bool tall = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 10, color: soft)),
        const SizedBox(height: 5),
        Container(
          height: tall ? 100 : 44,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          decoration: BoxDecoration(color: cream, borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.topLeft,
          child: Text(hint, style: TextStyle(fontSize: 12, color: soft)),
        ),
      ]),
    );
  }

  Widget _button(String text, Color color, {bool dark = false}) {
    return Container(
      height: 46,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(13)),
      child: Center(
        child: Text(text, style: TextStyle(color: dark ? const Color(0xFF211815) : Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _round(IconData icon, Color color) {
    return CircleAvatar(radius: 23, backgroundColor: color, child: Icon(icon, size: 18, color: Colors.white));
  }

  Widget _resultRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(children: [
        Icon(Icons.circle_outlined, size: 14, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        Text(value, style: const TextStyle(fontSize: 12)),
      ]),
    );
  }
}

class _SchoolTool {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SchoolTool(this.title, this.subtitle, this.icon, this.color);
}