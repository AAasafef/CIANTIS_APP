import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/journal_entry_model.dart';
import '../../services/journal_service.dart';
import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final PageController _pageController = PageController();
  final ScrollController _listScrollController = ScrollController();
  final ScrollController _calendarScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  bool _showBottomNav = true;
  DateTime _selectedDate = DateTime(2026, 6, 12);

  final List<JournalEntryModel> _demoEntries = const [];

  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_handleScroll);
    _calendarScrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final ScrollController activeController;

    if (_listScrollController.hasClients &&
        _listScrollController.position.isScrollingNotifier.value) {
      activeController = _listScrollController;
    } else if (_calendarScrollController.hasClients) {
      activeController = _calendarScrollController;
    } else {
      return;
    }

    final direction = activeController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse && _showBottomNav) {
      setState(() => _showBottomNav = false);
    }

    if (direction == ScrollDirection.forward && !_showBottomNav) {
      setState(() => _showBottomNav = true);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listScrollController.dispose();
    _calendarScrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<JournalEntryModel> get _entries {
    final entries = JournalService.instance.getEntries();

    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return entries;

    return entries.where((entry) {
      return entry.title.toLowerCase().contains(query) ||
          entry.content.toLowerCase().contains(query) ||
          entry.category.toLowerCase().contains(query) ||
          entry.mood.toLowerCase().contains(query) ||
          _formatDate(entry.createdAt).toLowerCase().contains(query) ||
          _formatTime(entry.createdAt).toLowerCase().contains(query);
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

  Future<void> _openEntry(JournalEntryModel entry) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _JournalEntryDetailScreen(entry: entry),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      setState(() {});
    }
  }

  void _createEntry() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const _JournalEditorScreen(),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _handleBottomNavTap(int index) {
    if (index == 0) {
      _goToList();
      return;
    }

    if (index == 1) {
      _goToCalendar();
      return;
    }

    if (index == 2) {
      _openGridMenu();
      return;
    }

    if (index == 3) {
      _createEntry();
      return;
    }

    if (index == 4) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CiantisSideDrawer(),
      backgroundColor: const Color(0xFFF4EFE8),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 58),
        child: GestureDetector(
          onTap: _createEntry,
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              color: Color(0xFF74624F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 21,
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset: _showBottomNav ? Offset.zero : const Offset(0, 1.35),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: _showBottomNav ? 1 : 0,
          child: _JournalIconBottomNav(
            onTap: _handleBottomNavTap,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            _JournalListPage(
              entries: _entries,
              scrollController: _listScrollController,
              searchController: _searchController,
              onSearchChanged: () => setState(() {}),
              onAdd: _createEntry,
              onCalendar: _goToCalendar,
              onEntryTap: _openEntry,
            ),
            _JournalCalendarPage(
              entries: _entries,
              scrollController: _calendarScrollController,
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 92),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopHeader(
            title: 'Journal',
            onAdd: onAdd,
          ),
          const SizedBox(height: 18),
          _SearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onCalendar,
            child: Text(
              'Recent Entries',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4D4239),
              ),
            ),
          ),
          const SizedBox(height: 8),
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
  final ScrollController scrollController;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectedDate;
  final VoidCallback onBackToList;
  final VoidCallback onAdd;
  final ValueChanged<JournalEntryModel> onEntryTap;

  const _JournalCalendarPage({
    required this.entries,
    required this.scrollController,
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
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 92),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopHeader(
            title: 'Journal Calendar',
            onAdd: onAdd,
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  onSelectedDate(
                    DateTime(
                      selectedDate.year,
                      selectedDate.month - 1,
                      1,
                    ),
                  );
                },
                child: const Icon(
                  Icons.chevron_left_rounded,
                  size: 26,
                  color: Color(0xFF4E4035),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _monthYear(selectedDate),
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  onSelectedDate(
                    DateTime(
                      selectedDate.year,
                      selectedDate.month + 1,
                      1,
                    ),
                  );
                },
                child: const Icon(
                  Icons.chevron_right_rounded,
                  size: 26,
                  color: Color(0xFF4E4035),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _CalendarGrid(
            selectedDate: selectedDate,
            entries: entries,
            onSelectedDate: onSelectedDate,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 17, 18, 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F2EA).withOpacity(.82),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _longDate(selectedDate),
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2D241E),
                  ),
                ),
                const SizedBox(height: 10),
                if (selectedEntries.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'No entries for this date.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF84776C),
                      ),
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


class _JournalEntryDetailScreen extends StatefulWidget {
  final JournalEntryModel entry;

  const _JournalEntryDetailScreen({
    required this.entry,
  });

  @override
  State<_JournalEntryDetailScreen> createState() =>
      _JournalEntryDetailScreenState();
}

class _JournalEntryDetailScreenState extends State<_JournalEntryDetailScreen> {
  late JournalEntryModel entry;

  @override
  void initState() {
    super.initState();
    entry = widget.entry;
  }

  Future<void> _deleteEntry() async {
    await JournalService.instance.deleteEntry(entry.id);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Future<void> _copyForShare() async {
    await Clipboard.setData(
      ClipboardData(
        text:
            '${entry.title}\n\n${_longDate(entry.createdAt)} at ${_formatTime(entry.createdAt)}\n\n${entry.content}',
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Entry copied for sharing.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _editEntry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _JournalEditorScreen(entry: entry),
      ),
    );

    if (result == true && mounted) {
      final updated = JournalService.instance
          .getEntries()
          .where((item) => item.id == entry.id);

      if (updated.isNotEmpty) {
        setState(() => entry = updated.first);
      } else {
        Navigator.pop(context, true);
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final updated = entry.copyWith(
      isFavorite: !entry.isFavorite,
      updatedAt: DateTime.now(),
    );
    await JournalService.instance.updateEntry(updated);
    if (mounted) setState(() => entry = updated);
  }

  Future<void> _togglePrivate() async {
    final updated = entry.copyWith(
      isPrivate: !entry.isPrivate,
      updatedAt: DateTime.now(),
    );
    await JournalService.instance.updateEntry(updated);
    if (mounted) setState(() => entry = updated);
  }

  Future<void> _changeEntryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: entry.createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF74624F),
              onPrimary: Colors.white,
              surface: Color(0xFFF8F2EA),
              onSurface: Color(0xFF2D241E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    final updated = entry.copyWith(
      createdAt: DateTime(
        picked.year,
        picked.month,
        picked.day,
        entry.createdAt.hour,
        entry.createdAt.minute,
      ),
      updatedAt: DateTime.now(),
    );

    await JournalService.instance.updateEntry(updated);
    if (mounted) setState(() => entry = updated);
  }

  void _openDetailOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          decoration: const BoxDecoration(
            color: Color(0xFFFFFBF5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8ADA3),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 18),
              _SheetAction(
                icon: Icons.calendar_today_outlined,
                title: 'Change Entry Date',
                onTap: () {
                  Navigator.pop(context);
                  _changeEntryDate();
                },
              ),
              _SheetAction(
                icon: entry.isFavorite
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
                title: entry.isFavorite ? 'Remove Favorite' : 'Mark Favorite',
                onTap: () {
                  Navigator.pop(context);
                  _toggleFavorite();
                },
              ),
              _SheetAction(
                icon: entry.isPrivate
                    ? Icons.lock_rounded
                    : Icons.lock_outline_rounded,
                title: entry.isPrivate ? 'Make Not Private' : 'Make Private',
                onTap: () {
                  Navigator.pop(context);
                  _togglePrivate();
                },
              ),
              _SheetAction(
                icon: Icons.edit_outlined,
                title: 'Edit Entry',
                onTap: () {
                  Navigator.pop(context);
                  _editEntry();
                },
              ),
              _SheetAction(
                icon: Icons.delete_outline_rounded,
                title: 'Delete Entry',
                onTap: () {
                  Navigator.pop(context);
                  _deleteEntry();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextStyle _bodyFont() {
    return _fontStyleFor(entry.fontStyle, const Color(0xFF211A15), 25);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: 246,
              child: CustomPaint(painter: _NotebookPaperPainter()),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context, true),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          size: 30,
                          color: Color(0xFF2D241E),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _openDetailOptions,
                        child: const Icon(
                          Icons.more_vert_rounded,
                          size: 24,
                          color: Color(0xFF2D241E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  Text(
                    entry.title,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _changeEntryDate,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_longDate(entry.createdAt)} at ${_formatTime(entry.createdAt)}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF6F6258),
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 13,
                          color: Color(0xFF8C8178),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text(
                        '♧  ${entry.category}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF7B6D62),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '•',
                        style: GoogleFonts.inter(color: const Color(0xFF9E9187)),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '☺  ${entry.mood}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF7B6D62),
                        ),
                      ),
                      if (entry.isFavorite) ...[
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFB08D57),
                        ),
                      ],
                      if (entry.isPrivate) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.lock_outline_rounded,
                          size: 15,
                          color: Color(0xFF7B6D62),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 54),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 4),
                    child: Text(entry.content, style: _bodyFont()),
                  ),
                  const SizedBox(height: 86),
                  _AiSummaryBox(content: entry.content),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 74,
                padding: const EdgeInsets.symmetric(horizontal: 62),
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
                  children: [
                    GestureDetector(
                      onTap: _deleteEntry,
                      child: const Icon(Icons.delete_outline_rounded),
                    ),
                    GestureDetector(
                      onTap: _copyForShare,
                      child: const Icon(Icons.ios_share_rounded),
                    ),
                    GestureDetector(
                      onTap: _editEntry,
                      child: const Icon(Icons.edit_outlined),
                    ),
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
  final JournalEntryModel? entry;

  const _JournalEditorScreen({this.entry});

  @override
  State<_JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends State<_JournalEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  Timer? _autoSaveTimer;

  late final String _entryId;
  late final DateTime _createdAt;

  DateTime _entryDate = DateTime.now();
  String _mood = 'Happy';
  String _category = 'General';
  String _fontStyle = 'Handwriting';
  double _fontSize = 18;
  bool _isFavorite = false;
  bool _isPrivate = false;
  bool _hasBeenSaved = false;
  bool _saving = false;
  bool _savedOnce = false;

  @override
  void initState() {
    super.initState();

    final entry = widget.entry;
    final now = DateTime.now();

    _entryId = entry?.id ?? now.microsecondsSinceEpoch.toString();
    _createdAt = entry?.createdAt ?? now;
    _entryDate = entry?.createdAt ?? now;

    if (entry != null) {
      _titleController.text = entry.title;
      _controller.text = entry.content;
      _mood = entry.mood;
      _category = entry.category;
      _fontStyle = entry.fontStyle;
      _fontSize = entry.fontSize;
      _isFavorite = entry.isFavorite;
      _isPrivate = entry.isPrivate;
      _hasBeenSaved = true;
      _savedOnce = true;
    }

    _titleController.addListener(_scheduleAutoSave);
    _controller.addListener(_scheduleAutoSave);
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _titleController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scheduleAutoSave() {
    _autoSaveTimer?.cancel();

    if (!_saving && mounted) {
      setState(() => _savedOnce = false);
    }

    _autoSaveTimer = Timer(
      const Duration(milliseconds: 500),
      _saveSilently,
    );
  }

  Future<void> _saveSilently() async {
    final content = _controller.text.trim();
    final typedTitle = _titleController.text.trim();

    if (content.isEmpty && typedTitle.isEmpty) return;

    if (mounted) {
      setState(() {
        _saving = true;
      });
    }

    final now = DateTime.now();

    final entry = JournalEntryModel(
      id: _entryId,
      title: typedTitle.isEmpty ? _autoTitle(content) : typedTitle,
      content: content,
      category: _category,
      mood: _mood,
      fontStyle: _fontStyle,
      fontSize: _fontSize,
      isFavorite: _isFavorite,
      isPrivate: _isPrivate,
      createdAt: DateTime(
        _entryDate.year,
        _entryDate.month,
        _entryDate.day,
        _createdAt.hour,
        _createdAt.minute,
      ),
      updatedAt: now,
    );

    if (_hasBeenSaved) {
      await JournalService.instance.updateEntry(entry);
    } else {
      await JournalService.instance.addEntry(entry);
      _hasBeenSaved = true;
    }

    if (mounted) {
      setState(() {
        _saving = false;
        _savedOnce = true;
      });
    }
  }

  Future<void> _exit() async {
    _autoSaveTimer?.cancel();
    await _saveSilently();

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _pickEntryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _entryDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF74624F),
              onPrimary: Colors.white,
              surface: Color(0xFFF8F2EA),
              onSurface: Color(0xFF2D241E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      _entryDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _entryDate.hour,
        _entryDate.minute,
      );
    });

    _scheduleAutoSave();
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

  TextStyle _editorFont({Color color = const Color(0xFF211A15), double? size}) {
    return _fontStyleFor(_fontStyle, color, size ?? _fontSize);
  }

  void _openOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, sheetSetState) {
            void changeFontSize(double change) {
              final next = (_fontSize + change).clamp(14.0, 34.0);

              setState(() {
                _fontSize = next;
              });

              sheetSetState(() {});
              _scheduleAutoSave();
            }

            return Container(
              height: MediaQuery.of(context).size.height * .86,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFBF5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8ADA3),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Entry Options',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 30,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _OptionCard(
                    title: 'Entry Date',
                    child: _SheetAction(
                      icon: Icons.calendar_today_outlined,
                      title: _longDate(_entryDate),
                      onTap: () async {
                        await _pickEntryDate();
                        sheetSetState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  _OptionCard(
                    title: 'Font Size',
                    child: Row(
                      children: [
                        _RoundControl(
                          icon: Icons.remove_rounded,
                          onTap: () => changeFontSize(-1),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '${_fontSize.round()}',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 26,
                                color: const Color(0xFF2D241E),
                              ),
                            ),
                          ),
                        ),
                        _RoundControl(
                          icon: Icons.edit_rounded,
                          onTap: () => changeFontSize(1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _OptionCard(
                    title: 'Mood',
                    child: Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children: [
                        for (final mood in const [
                          'Happy',
                          'Calm',
                          'Grateful',
                          'Motivated',
                          'Reflective',
                          'Sad',
                        ])
                          _ChoicePill(
                            label: mood,
                            selected: _mood == mood,
                            onTap: () {
                              setState(() => _mood = mood);
                              sheetSetState(() {});
                              _scheduleAutoSave();
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _OptionCard(
                    title: 'Space',
                    child: Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children: [
                        for (final category in const [
                          'General',
                          'Spiritual',
                          'Wellness',
                          'School',
                          'Family',
                          'Work',
                          'Beauty',
                          'Business',
                          'Money',
                        ])
                          _ChoicePill(
                            label: category,
                            selected: _category == category,
                            onTap: () {
                              setState(() => _category = category);
                              sheetSetState(() {});
                              _scheduleAutoSave();
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _OptionCard(
                    title: 'Font',
                    child: Column(
                      children: [
                        for (final font in _journalFonts)
                          _FontPreviewTile(
                            fontName: font,
                            selected: _fontStyle == font,
                            onTap: () {
                              setState(() => _fontStyle = font);
                              sheetSetState(() {});
                              _scheduleAutoSave();
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _OptionCard(
                    title: 'Privacy',
                    child: Column(
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          value: _isPrivate,
                          activeThumbColor: const Color(0xFFB08D57),
                          title: Text(
                            'Private Entry',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF2D241E),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => _isPrivate = value);
                            sheetSetState(() {});
                            _scheduleAutoSave();
                          },
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          value: _isFavorite,
                          activeThumbColor: const Color(0xFFB08D57),
                          title: Text(
                            'Favorite Entry',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF2D241E),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => _isFavorite = value);
                            sheetSetState(() {});
                            _scheduleAutoSave();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String saveText;

    if (_saving) {
      saveText = 'Saving...';
    } else if (_savedOnce) {
      saveText = 'Saved';
    } else {
      saveText = '';
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) _exit();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4EFE8),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _exit,
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            size: 30,
                            color: Color(0xFF2D241E),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _openOptions,
                          child: const Icon(
                            Icons.more_horiz_rounded,
                            size: 26,
                            color: Color(0xFF2D241E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      controller: _titleController,
                      cursorColor: const Color(0xFF74624F),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: GoogleFonts.cormorantGaramond(
                          fontSize: 22,
                          color: const Color(0xFF9A8E83),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 22,
                        height: 1.05,
                        color: const Color(0xFF2D241E),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _NotebookPaperPainter(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(42, 0, 22, 0),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        cursorColor: const Color(0xFF74624F),
                        decoration: InputDecoration(
                          hintText: 'Write freely...',
                          hintStyle: _editorFont(
                            color: const Color(0xFF9A8E83),
                            size: 18,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(top: 3),
                        ),
                        style: _editorFont(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
                child: Row(
                  children: [
                    Text(
                      saveText,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: const Color(0xFF8C8178),
                      ),
                    ),
                    const Spacer(),
                    if (_isFavorite)
                      const Icon(
                        Icons.star_rounded,
                        size: 17,
                        color: Color(0xFFB08D57),
                      ),
                    if (_isPrivate) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.lock_outline_rounded,
                        size: 16,
                        color: Color(0xFF7B6D62),
                      ),
                    ],
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _pickEntryDate,
                      child: Text(
                        _longDate(_entryDate),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: const Color(0xFFAA9C8F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundControl({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 38,
        decoration: const BoxDecoration(
          color: Color(0xFFE6D7C7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF2D241E),
          size: 20,
        ),
      ),
    );
  }
}

class _SheetAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SheetAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFF74624F)),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF2D241E),
        ),
      ),
      onTap: onTap,
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _OptionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA).withOpacity(.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD8CEC4).withOpacity(.65),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              letterSpacing: 1.45,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF74624F),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _ChoicePill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChoicePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE6D7C7) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? const Color(0xFFB08D57)
                : const Color(0xFFD8CEC4),
            width: .8,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF2D241E),
          ),
        ),
      ),
    );
  }
}

class _FontPreviewTile extends StatelessWidget {
  final String fontName;
  final bool selected;
  final VoidCallback onTap;

  const _FontPreviewTile({
    required this.fontName,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(
        fontName,
        style: _fontStyleFor(fontName, const Color(0xFF2D241E), 21),
      ),
      subtitle: Text(
        'The way your entry will feel.',
        style: GoogleFonts.inter(
          fontSize: 10.5,
          color: const Color(0xFF8C8178),
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_rounded, color: Color(0xFFB08D57))
          : null,
    );
  }
}

const List<String> _journalFonts = [
  'Handwriting',
  'Parisienne',
  'Allura',
  'Petit Formal Script',
  'Calendar Serif',
  'Cormorant Garamond',
  'Playfair Display',
  'Bodoni Moda',
  'Prata',
  'Lora',
  'Libre Baskerville',
  'EB Garamond',
  'Marcellus',
  'Forum',
  'Inter',
  'Manrope',
  'Outfit',
  'Urbanist',
  'DM Sans',
  'Plus Jakarta Sans',
  'Work Sans',
  'Typewriter',
];

TextStyle _fontStyleFor(String fontName, Color color, double size) {
  switch (fontName) {
    case 'Calendar Serif':
    case 'Cormorant Garamond':
    case 'Cormorant':
    case 'Elegant Serif':
      return GoogleFonts.cormorantGaramond(fontSize: size + 2, color: color, height: 1.25);
    case 'Playfair Display':
    case 'Modern Serif':
      return GoogleFonts.playfairDisplay(fontSize: size, color: color, height: 1.25);
    case 'Bodoni Moda':
      return GoogleFonts.bodoniModa(fontSize: size, color: color, height: 1.25);
    case 'Prata':
      return GoogleFonts.prata(fontSize: size - 1, color: color, height: 1.3);
    case 'Lora':
      return GoogleFonts.lora(fontSize: size, color: color, height: 1.35);
    case 'Libre Baskerville':
      return GoogleFonts.libreBaskerville(fontSize: size - 3, color: color, height: 1.45);
    case 'EB Garamond':
      return GoogleFonts.ebGaramond(fontSize: size + 1, color: color, height: 1.3);
    case 'Marcellus':
      return GoogleFonts.marcellus(fontSize: size, color: color, height: 1.35);
    case 'Forum':
      return GoogleFonts.forum(fontSize: size + 1, color: color, height: 1.28);
    case 'Manrope':
      return GoogleFonts.manrope(fontSize: size - 4, color: color, height: 1.55);
    case 'Outfit':
      return GoogleFonts.outfit(fontSize: size - 3, color: color, height: 1.5);
    case 'Urbanist':
      return GoogleFonts.urbanist(fontSize: size - 3, color: color, height: 1.5);
    case 'DM Sans':
      return GoogleFonts.dmSans(fontSize: size - 4, color: color, height: 1.55);
    case 'Plus Jakarta Sans':
      return GoogleFonts.plusJakartaSans(fontSize: size - 4, color: color, height: 1.55);
    case 'Work Sans':
      return GoogleFonts.workSans(fontSize: size - 4, color: color, height: 1.55);
    case 'Inter':
    case 'Clean Sans':
      return GoogleFonts.inter(fontSize: size - 4, color: color, height: 1.55);
    case 'Parisienne':
      return GoogleFonts.parisienne(fontSize: size + 7, color: color, height: 1.25);
    case 'Allura':
      return GoogleFonts.allura(fontSize: size + 9, color: color, height: 1.15);
    case 'Petit Formal Script':
      return GoogleFonts.petitFormalScript(fontSize: size - 2, color: color, height: 1.55);
    case 'Typewriter':
      return GoogleFonts.dmMono(fontSize: size - 5, color: color, height: 1.5);
    case 'Handwriting':
    default:
      return GoogleFonts.caveat(fontSize: size + 4, color: color, height: 1.22);
  }
}

class _TopHeader extends StatelessWidget {
  final String title;
  final VoidCallback onAdd;
  final IconData? trailingIcon;

  const _TopHeader({
    required this.title,
    required this.onAdd,
    this.trailingIcon,
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
                size: 26,
                color: Color(0xFF2D241E),
              ),
            );
          },
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: GoogleFonts.cormorantGaramond(
              fontSize: title.length > 12 ? 31 : 34,
              fontWeight: FontWeight.w400,
              height: 1,
              color: const Color(0xFF2D241E),
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
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA),
        borderRadius: BorderRadius.circular(16),
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
            size: 20,
          ),
          hintText: 'Search your thoughts...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF8C8178),
            fontSize: 13,
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: 13,
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
        padding: const EdgeInsets.only(bottom: 12, top: 0),
        margin: const EdgeInsets.only(bottom: 8),
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
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.02,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _formatTime(entry.createdAt),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF2D241E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              entry.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 12.5,
                height: 1.28,
                color: const Color(0xFF332B25),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _formatDate(entry.createdAt),
              style: GoogleFonts.inter(
                fontSize: 10.5,
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
        padding: const EdgeInsets.symmetric(vertical: 12),
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
              width: 58,
              child: Text(
                _formatTime(entry.createdAt),
                style: GoogleFonts.inter(
                  fontSize: 11,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF2D241E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      height: 1.28,
                      color: const Color(0xFF5E5249),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF8C8178),
              size: 20,
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
      return entry.createdAt.year == selectedDate.year &&
          entry.createdAt.month == selectedDate.month &&
          entry.createdAt.day == day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      1,
    );

    final daysInMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    ).day;

    final previousMonthDays = DateTime(
      selectedDate.year,
      selectedDate.month,
      0,
    ).day;

    final startOffset = firstDayOfMonth.weekday % 7;
    final totalCells = ((startOffset + daysInMonth) / 7).ceil() * 7;

    final labels = List.generate(totalCells, (index) {
      final dayNumber = index - startOffset + 1;

      if (dayNumber < 1) {
        return _CalendarDay(
          label: '${previousMonthDays + dayNumber}',
          day: previousMonthDays + dayNumber,
          isCurrentMonth: false,
        );
      }

      if (dayNumber > daysInMonth) {
        return _CalendarDay(
          label: '${dayNumber - daysInMonth}',
          day: dayNumber - daysInMonth,
          isCurrentMonth: false,
        );
      }

      return _CalendarDay(
        label: '$dayNumber',
        day: dayNumber,
        isCurrentMonth: true,
      );
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
            return SizedBox(
              width: 34,
              child: Center(
                child: Text(
                  day,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF6F6258),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: labels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 7,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            final item = labels[index];

            final isSelected =
                item.isCurrentMonth && selectedDate.day == item.day;

            return GestureDetector(
              onTap: item.isCurrentMonth
                  ? () => onSelectedDate(
                        DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          item.day,
                        ),
                      )
                  : null,
              child: Column(
                children: [
                  Container(
                    height: 34,
                    width: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? const Color(0xFF9A8977)
                          : Colors.transparent,
                    ),
                    child: Text(
                      item.label,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: !item.isCurrentMonth
                            ? const Color(0xFFB8ADA3)
                            : isSelected
                                ? Colors.white
                                : const Color(0xFF2D241E),
                      ),
                    ),
                  ),
                  if (item.isCurrentMonth && _hasEntry(item.day))
                    Container(
                      height: 3.5,
                      width: 3.5,
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

class _CalendarDay {
  final String label;
  final int day;
  final bool isCurrentMonth;

  const _CalendarDay({
    required this.label,
    required this.day,
    required this.isCurrentMonth,
  });
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA).withOpacity(.86),
        borderRadius: BorderRadius.circular(16),
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
              fontSize: 13,
              color: const Color(0xFF2D241E),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            _summary(content),
            style: GoogleFonts.inter(
              fontSize: 12,
              height: 1.4,
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
        padding: const EdgeInsets.symmetric(vertical: 34),
        child: Column(
          children: [
            Text(
              'Welcome to your Journal',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 25,
                color: const Color(0xFF2D241E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Write freely. CIANTIS will organize it.',
              textAlign: TextAlign.center,
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

class _JournalIconBottomNav extends StatelessWidget {
  final ValueChanged<int> onTap;

  const _JournalIconBottomNav({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(34, 0, 34, 10),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFF4EFE8).withOpacity(.86),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _JournalNavIcon(
                icon: Icons.notes_rounded,
                onTap: () => onTap(0),
              ),
              _JournalNavIcon(
                icon: Icons.calendar_month_outlined,
                onTap: () => onTap(1),
              ),
              _JournalNavIcon(
                icon: Icons.grid_view_rounded,
                onTap: () => onTap(2),
              ),
              _JournalNavIcon(
                icon: Icons.edit_outlined,
                onTap: () => onTap(3),
              ),
              _JournalNavIcon(
                icon: Icons.home_outlined,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JournalNavIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _JournalNavIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        height: 46,
        width: 46,
        child: Icon(
          icon,
          size: 22,
          color: const Color(0xFF4A3F37),
        ),
      ),
    );
  }
}

class _NotebookPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFD3C7BD).withOpacity(.52)
      ..strokeWidth = .55;

    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        linePaint,
      );
    }

    final marginPaint = Paint()
      ..color = const Color(0xFFE1A9A2).withOpacity(.42)
      ..strokeWidth = .75;

    canvas.drawLine(
      const Offset(102, 0),
      Offset(102, size.height),
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

String _monthYear(DateTime date) {
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

  return '${months[date.month - 1]} ${date.year}';
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
