import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/journal_entry_model.dart';
import '../../services/journal_service.dart';
import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  bool _showBottomNav = true;
  int _pageIndex = 0;
  DateTime _selectedDate = DateTime(2026, 6, 12);

  final List<JournalEntryModel> _demoEntries = [
    JournalEntryModel(
      id: 'demo_1',
      title: 'App Reflection',
      content:
          'Fixed notes layout and organized uploads. Happy with the progress.',
      createdAt: DateTime(2026, 6, 1, 7, 42),
    ),
    JournalEntryModel(
      id: 'demo_2',
      title: 'Prayer Reflection',
      content:
          'Felt peaceful after devotional study. Grateful for today’s blessings.',
      createdAt: DateTime(2026, 5, 31, 20, 16),
    ),
    JournalEntryModel(
      id: 'demo_3',
      title: 'Wellness Check-In',
      content:
          'Needed more rest and hydration today. Tomorrow I’ll plan my meals better.',
      createdAt: DateTime(2026, 5, 30, 21, 22),
    ),
    JournalEntryModel(
      id: 'demo_4',
      title: 'Gratitude Journal',
      content:
          'Grateful for good health, family, and another beautiful day.',
      createdAt: DateTime(2026, 5, 29, 22, 5),
    ),
    JournalEntryModel(
      id: 'demo_5',
      title: 'Mindful Moments',
      content:
          'Took a walk, cleared my mind, and felt completely refreshed.',
      createdAt: DateTime(2026, 5, 28, 18, 38),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final direction =
          _scrollController.position.userScrollDirection;

      if (direction == ScrollDirection.reverse && _showBottomNav) {
        setState(() => _showBottomNav = false);
      }

      if (direction == ScrollDirection.forward && !_showBottomNav) {
        setState(() => _showBottomNav = true);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<JournalEntryModel> get _entries {
    final saved = JournalService.instance.getEntries();

    final hasRealEntries =
        saved.any((entry) => !entry.id.startsWith('demo_'));

    final entries = hasRealEntries ? saved : _demoEntries;

    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return entries;

    return entries.where((entry) {
      return entry.title.toLowerCase().contains(query) ||
          entry.content.toLowerCase().contains(query) ||
          _formatDate(entry.createdAt).toLowerCase().contains(query);
    }).toList();
  }

  void _openGridMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const GridMenu(),
    );
  }

  void _handleBottomNavTap(int index) {
    if (index == 2) {
      _openGridMenu();
    }
  }

  void _goToCalendar() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToList() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void _openEntry(JournalEntryModel entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _JournalEntryDetailScreen(entry: entry),
      ),
    );
  }

  void _createEntry() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const _JournalEditorScreen(),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CiantisSideDrawer(),
      backgroundColor: const Color(0xFFF4EFE8),
      extendBody: true,
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset: _showBottomNav ? Offset.zero : const Offset(0, 1.2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: _showBottomNav ? 1 : 0,
          child: SpacesBottomNavBar(
            currentIndex: 2,
            onTap: _handleBottomNavTap,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _pageIndex = index);
          },
          children: [
            _JournalListPage(
              entries: _entries,
              scrollController: _scrollController,
              searchController: _searchController,
              onSearchChanged: () => setState(() {}),
              onAdd: _createEntry,
              onCalendar: _goToCalendar,
              onEntryTap: _openEntry,
            ),
            _JournalCalendarPage(
              entries: _entries,
              selectedDate: _selectedDate,
              onSelectedDate: (date) {
                setState(() => _selectedDate = date);
              },
              onBackToList: _goToList,
              onAdd: _createEntry,
              onEntryTap: _openEntry,
            ),
          ],
        ),
      ),
    );
  }
}

class _JournalListPage extends StatelessWidget {
  final List<JournalEntryModel> entries;
  final ScrollController scrollController;
  final TextEditingController searchController;
  final VoidCallback onSearchChanged;
  final VoidCallback onAdd;
  final VoidCallback onCalendar;
  final ValueChanged<JournalEntryModel> onEntryTap;

  const _JournalListPage({
    required this.entries,
    required this.scrollController,
    required this.searchController,
    required this.onSearchChanged,
    required this.onAdd,
    required this.onCalendar,
    required this.onEntryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(28, 30, 28, 130),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopHeader(
            title: 'Journal',
            onAdd: onAdd,
            trailingIcon: Icons.add_rounded,
          ),
          const SizedBox(height: 24),
          _SearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 34),
          GestureDetector(
            onTap: onCalendar,
            child: Text(
              'Recent Entries',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4D4239),
              ),
            ),
          ),
          const SizedBox(height: 18),
          if (entries.isEmpty)
            _EmptyJournalState(onAdd: onAdd)
          else
            ...entries.map(
              (entry) => _SlimEntryTile(
                entry: entry,
                onTap: () => onEntryTap(entry),
              ),
            ),
        ],
      ),
    );
  }
}

class _JournalCalendarPage extends StatelessWidget {
  final List<JournalEntryModel> entries;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectedDate;
  final VoidCallback onBackToList;
  final VoidCallback onAdd;
  final ValueChanged<JournalEntryModel> onEntryTap;

  const _JournalCalendarPage({
    required this.entries,
    required this.selectedDate,
    required this.onSelectedDate,
    required this.onBackToList,
    required this.onAdd,
    required this.onEntryTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedEntries = entries.where((entry) {
      return entry.createdAt.year == selectedDate.year &&
          entry.createdAt.month == selectedDate.month &&
          entry.createdAt.day == selectedDate.day;
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(28, 30, 28, 130),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopHeader(
            title: 'Journal Calendar',
            onAdd: onAdd,
            trailingIcon: Icons.add_rounded,
          ),
          const SizedBox(height: 34),
          Row(
            children: [
              GestureDetector(
                onTap: onBackToList,
                child: const Icon(
                  Icons.chevron_left_rounded,
                  size: 28,
                  color: Color(0xFF4E4035),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'June 2026',
                    style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 28,
                color: Color(0xFF4E4035),
              ),
            ],
          ),
          const SizedBox(height: 26),
          _CalendarGrid(
            selectedDate: selectedDate,
            entries: entries,
            onSelectedDate: onSelectedDate,
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 18),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F2EA).withOpacity(.82),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _longDate(selectedDate),
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2D241E),
                  ),
                ),
                const SizedBox(height: 16),
                if (selectedEntries.isEmpty)
                  Text(
                    'No entries for this date.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF84776C),
                    ),
                  )
                else
                  ...selectedEntries.map(
                    (entry) => _CalendarEntryTile(
                      entry: entry,
                      onTap: () => onEntryTap(entry),
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

class _JournalEntryDetailScreen extends StatelessWidget {
  final JournalEntryModel entry;

  const _JournalEntryDetailScreen({
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: 255,
              child: CustomPaint(
                painter: _NotebookPaperPainter(),
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(28, 30, 28, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          size: 30,
                          color: Color(0xFF2D241E),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.more_vert_rounded,
                        size: 24,
                        color: Color(0xFF2D241E),
                      ),
                    ],
                  ),
                  const SizedBox(height: 42),
                  Text(
                    entry.title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_longDate(entry.createdAt)} at ${_formatTime(entry.createdAt)}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF6F6258),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Text(
                        '♧  General',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF7B6D62),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '•',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9E9187),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '☺  Happy',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF7B6D62),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 58),
                  Padding(
                    padding: const EdgeInsets.only(left: 34, right: 6),
                    child: Text(
                      entry.content,
                      style: GoogleFonts.caveat(
                        fontSize: 26,
                        height: 1.18,
                        color: const Color(0xFF211A15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 140),
                  _AiSummaryBox(content: entry.content),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 86,
                padding: const EdgeInsets.symmetric(horizontal: 58),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4EFE8).withOpacity(.96),
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFFD8CEC4).withOpacity(.55),
                      width: .7,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.delete_outline_rounded),
                    Icon(Icons.ios_share_rounded),
                    Icon(Icons.edit_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JournalEditorScreen extends StatefulWidget {
  const _JournalEditorScreen();

  @override
  State<_JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends State<_JournalEditorScreen> {
  final TextEditingController _controller = TextEditingController();

  void _save() {
    final content = _controller.text.trim();

    if (content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final entry = JournalEntryModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _autoTitle(content),
      content: content,
      createdAt: DateTime.now(),
    );

    JournalService.instance.addEntry(entry);

    Navigator.pop(context);
  }

  String _autoTitle(String content) {
    final clean = content
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (clean.isEmpty) return 'Journal Entry';

    final words = clean.split(' ').take(4).join(' ');

    return words.length < 8 ? 'Today’s Reflection' : words;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: 170,
              child: CustomPaint(
                painter: _NotebookPaperPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          size: 30,
                          color: Color(0xFF2D241E),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _save,
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF74624F),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Entry',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2D241E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      cursorColor: const Color(0xFF74624F),
                      decoration: InputDecoration(
                        hintText: 'Write freely...',
                        hintStyle: GoogleFonts.caveat(
                          fontSize: 28,
                          color: const Color(0xFF9A8E83),
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.caveat(
                        fontSize: 28,
                        height: 1.25,
                        color: const Color(0xFF211A15),
                      ),
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
}

class _TopHeader extends StatelessWidget {
  final String title;
  final VoidCallback onAdd;
  final IconData trailingIcon;

  const _TopHeader({
    required this.title,
    required this.onAdd,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Icon(
                Icons.menu_rounded,
                size: 28,
                color: Color(0xFF2D241E),
              ),
            );
          },
        ),
        const SizedBox(width: 28),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36,
              fontWeight: FontWeight.w400,
              height: 1,
              color: const Color(0xFF2D241E),
            ),
          ),
        ),
        GestureDetector(
          onTap: onAdd,
          child: Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF74624F),
              shape: BoxShape.circle,
            ),
            child: Icon(
              trailingIcon,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const _SearchField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD8CEC4).withOpacity(.75),
          width: .7,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: (_) => onChanged(),
        cursorColor: const Color(0xFF74624F),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6C5E53),
            size: 22,
          ),
          hintText: 'Search your thoughts...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF8C8178),
            fontSize: 14,
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF2D241E),
        ),
      ),
    );
  }
}

class _SlimEntryTile extends StatelessWidget {
  final JournalEntryModel entry;
  final VoidCallback onTap;

  const _SlimEntryTile({
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20, top: 2),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFFD8CEC4).withOpacity(.72),
              width: .7,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    entry.title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      height: 1.05,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  _formatTime(entry.createdAt),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF2D241E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              entry.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.35,
                color: const Color(0xFF332B25),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(entry.createdAt),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF7F7268),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarEntryTile extends StatelessWidget {
  final JournalEntryModel entry;
  final VoidCallback onTap;

  const _CalendarEntryTile({
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: const Color(0xFFD8CEC4).withOpacity(.72),
              width: .7,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: Text(
                _formatTime(entry.createdAt),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF4D4239),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.35,
                      color: const Color(0xFF5E5249),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF8C8178),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final DateTime selectedDate;
  final List<JournalEntryModel> entries;
  final ValueChanged<DateTime> onSelectedDate;

  const _CalendarGrid({
    required this.selectedDate,
    required this.entries,
    required this.onSelectedDate,
  });

  bool _hasEntry(int day) {
    return entries.any((entry) {
      return entry.createdAt.year == 2026 &&
          entry.createdAt.month == 6 &&
          entry.createdAt.day == day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = [
      '31',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '1',
      '2',
      '3',
      '4',
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((d) {
            return SizedBox(
              width: 36,
              child: Center(
                child: Text(
                  d,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF6F6258),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 12,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final label = days[index];
            final day = int.tryParse(label) ?? 1;
            final isCurrentMonth = index >= 1 && index <= 30;
            final isSelected =
                isCurrentMonth && selectedDate.day == day;

            return GestureDetector(
              onTap: isCurrentMonth
                  ? () => onSelectedDate(DateTime(2026, 6, day))
                  : null,
              child: Column(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? const Color(0xFF9A8977)
                          : Colors.transparent,
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: !isCurrentMonth
                            ? const Color(0xFFB8ADA3)
                            : isSelected
                                ? Colors.white
                                : const Color(0xFF2D241E),
                      ),
                    ),
                  ),
                  if (isCurrentMonth && _hasEntry(day))
                    Container(
                      height: 4,
                      width: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9A8977),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AiSummaryBox extends StatelessWidget {
  final String content;

  const _AiSummaryBox({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA).withOpacity(.86),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD8CEC4),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✧  AI Summary',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF2D241E),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _summary(content),
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.45,
              color: const Color(0xFF3F352E),
            ),
          ),
        ],
      ),
    );
  }

  String _summary(String value) {
    if (value.length <= 120) return value;
    return '${value.substring(0, 120)}...';
  }
}

class _EmptyJournalState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyJournalState({
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Text(
              'Welcome to your Journal',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 28,
                color: const Color(0xFF2D241E),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Write freely. CIANTIS will organize it.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF7F7268),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotebookPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFD3C7BD).withOpacity(.55)
      ..strokeWidth = .6;

    for (double y = 0; y < size.height; y += 31) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        linePaint,
      );
    }

    final marginPaint = Paint()
      ..color = const Color(0xFFE1A9A2).withOpacity(.45)
      ..strokeWidth = .8;

    canvas.drawLine(
      const Offset(62, 0),
      Offset(62, size.height),
      marginPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

String _formatDate(DateTime date) {
  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

String _longDate(DateTime date) {
  return _formatDate(date);
}

String _formatTime(DateTime date) {
  final hour = date.hour == 0
      ? 12
      : date.hour > 12
          ? date.hour - 12
          : date.hour;

  final minute = date.minute.toString().padLeft(2, '0');
  final suffix = date.hour >= 12 ? 'PM' : 'AM';

  return '$hour:$minute $suffix';
}