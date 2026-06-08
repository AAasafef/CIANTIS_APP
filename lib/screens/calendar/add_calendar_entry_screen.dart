import 'package:flutter/material.dart';

import 'birthday_quick_add_screen.dart';

class AddCalendarEntryScreen extends StatefulWidget {
  final DateTime initialDate;

  const AddCalendarEntryScreen({
    super.key,
    required this.initialDate,
  });

  @override
  State<AddCalendarEntryScreen> createState() =>
      _AddCalendarEntryScreenState();
}

class _AddCalendarEntryScreenState
    extends State<AddCalendarEntryScreen> {
  final TextEditingController titleController =
      TextEditingController();
  final TextEditingController notesController =
      TextEditingController();
  final TextEditingController locationController =
      TextEditingController();

  String entryType = 'Event';
  String category = 'Personal';
  String repeat = 'Never';
  String alert = '15 minutes before';
  String priority = 'Normal';
  String linkedSpace = 'None';
  String colorName = 'Taupe';

  bool allDay = false;
  bool privateEntry = false;
  bool addToFamilyCalendar = false;
  bool addToTasks = false;

  late DateTime startDate;
  late DateTime endDate;
  TimeOfDay startTime = const TimeOfDay(
    hour: 9,
    minute: 0,
  );
  TimeOfDay endTime = const TimeOfDay(
    hour: 10,
    minute: 0,
  );

  @override
  void initState() {
    super.initState();
    startDate = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      widget.initialDate.day,
    );
    endDate = startDate;
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required bool isStart,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
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

    if (picked == null) return;

    setState(() {
      if (isStart) {
        startDate = picked;
        if (endDate.isBefore(startDate)) {
          endDate = startDate;
        }
      } else {
        endDate = picked;
      }
    });
  }

  Future<void> _pickTime({
    required bool isStart,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
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

    if (picked == null) return;

    setState(() {
      if (isStart) {
        startTime = picked;
      } else {
        endTime = picked;
      }
    });
  }

  void _openBirthdayQuickAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BirthdayQuickAddScreen(
          initialDate: startDate,
        ),
      ),
    );
  }

  void _saveEntry({
    required bool addAnother,
  }) {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add a title first.'),
        ),
      );
      return;
    }

    if (addAnother) {
      titleController.clear();
      notesController.clear();
      locationController.clear();
      setState(() {
        entryType = 'Event';
        category = 'Personal';
        repeat = 'Never';
        alert = '15 minutes before';
        priority = 'Normal';
        linkedSpace = 'None';
        colorName = 'Taupe';
        allDay = false;
        privateEntry = false;
        addToFamilyCalendar = false;
        addToTasks = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved. Ready for the next entry.'),
        ),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            22,
            18,
            22,
            34,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(),
              const SizedBox(height: 26),
              const Text(
                'Add Entry',
                style: TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 44,
                  height: .96,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 9),
              const Text(
                'EVENTS · TASKS · REMINDERS · ROUTINES',
                style: TextStyle(
                  color: Color(0xFF8B7D72),
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.4,
                ),
              ),
              const SizedBox(height: 24),
              _birthdayShortcut(),
              const SizedBox(height: 18),
              _sectionCard(
                title: 'Entry Type',
                child: _chipWrap(
                  options: const [
                    'Event',
                    'Task',
                    'Reminder',
                    'Appointment',
                    'Routine',
                    'Birthday',
                    'Deadline',
                  ],
                  selected: entryType,
                  onSelected: (value) {
                    if (value == 'Birthday') {
                      _openBirthdayQuickAdd();
                      return;
                    }

                    setState(() {
                      entryType = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Main Info',
                child: Column(
                  children: [
                    _inputField(
                      controller: titleController,
                      label: 'Title',
                      hint: 'Example: Study session, client appointment, dinner',
                    ),
                    const SizedBox(height: 14),
                    _dropdownTile(
                      label: 'Category',
                      value: category,
                      options: const [
                        'Personal',
                        'Family',
                        'School',
                        'Work',
                        'Business',
                        'Beauty',
                        'Spiritual',
                        'Health',
                        'Money',
                      ],
                      onChanged: (value) {
                        setState(() {
                          category = value;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    _inputField(
                      controller: locationController,
                      label: 'Location',
                      hint: 'Optional address, place, room, or link',
                    ),
                    const SizedBox(height: 14),
                    _inputField(
                      controller: notesController,
                      label: 'Notes',
                      hint: 'Details, prep list, reminders, or instructions',
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Date & Time',
                child: Column(
                  children: [
                    _switchTile(
                      title: 'All day',
                      subtitle: 'Hide exact times and keep this as a full-day entry.',
                      value: allDay,
                      onChanged: (value) {
                        setState(() {
                          allDay = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _dateTimeButton(
                            label: 'Start Date',
                            value: _formatDate(startDate),
                            onTap: () => _pickDate(isStart: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _dateTimeButton(
                            label: 'End Date',
                            value: _formatDate(endDate),
                            onTap: () => _pickDate(isStart: false),
                          ),
                        ),
                      ],
                    ),
                    if (!allDay) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _dateTimeButton(
                              label: 'Start Time',
                              value: startTime.format(context),
                              onTap: () => _pickTime(isStart: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _dateTimeButton(
                              label: 'End Time',
                              value: endTime.format(context),
                              onTap: () => _pickTime(isStart: false),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 14),
                    _dropdownTile(
                      label: 'Repeat',
                      value: repeat,
                      options: const [
                        'Never',
                        'Daily',
                        'Weekdays',
                        'Weekly',
                        'Biweekly',
                        'Monthly',
                        'Yearly',
                        'Custom later',
                      ],
                      onChanged: (value) {
                        setState(() {
                          repeat = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Priority & Alerts',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _labelText('Priority'),
                    const SizedBox(height: 10),
                    _chipWrap(
                      options: const [
                        'Low',
                        'Normal',
                        'High',
                        'Urgent',
                      ],
                      selected: priority,
                      onSelected: (value) {
                        setState(() {
                          priority = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _dropdownTile(
                      label: 'Alert',
                      value: alert,
                      options: const [
                        'None',
                        'At time of event',
                        '5 minutes before',
                        '15 minutes before',
                        '30 minutes before',
                        '1 hour before',
                        '1 day before',
                        '1 week before',
                      ],
                      onChanged: (value) {
                        setState(() {
                          alert = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Extras',
                child: Column(
                  children: [
                    _dropdownTile(
                      label: 'Link to Space',
                      value: linkedSpace,
                      options: const [
                        'None',
                        'Family',
                        'School',
                        'Work',
                        'Business',
                        'Beauty',
                        'Spiritual',
                        'Health',
                        'Money',
                      ],
                      onChanged: (value) {
                        setState(() {
                          linkedSpace = value;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    _dropdownTile(
                      label: 'Color Tag',
                      value: colorName,
                      options: const [
                        'Taupe',
                        'Mocha',
                        'Champagne',
                        'Sage',
                        'Rose',
                        'Charcoal',
                      ],
                      onChanged: (value) {
                        setState(() {
                          colorName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _switchTile(
                      title: 'Private / locked entry',
                      subtitle: 'Hide sensitive details later behind privacy settings.',
                      value: privateEntry,
                      onChanged: (value) {
                        setState(() {
                          privateEntry = value;
                        });
                      },
                    ),
                    _switchTile(
                      title: 'Add to Family calendar',
                      subtitle: 'Useful for birthdays, school events, and custody plans.',
                      value: addToFamilyCalendar,
                      onChanged: (value) {
                        setState(() {
                          addToFamilyCalendar = value;
                        });
                      },
                    ),
                    _switchTile(
                      title: 'Also add as task',
                      subtitle: 'Good for deadlines, errands, and things to complete.',
                      value: addToTasks,
                      onChanged: (value) {
                        setState(() {
                          addToTasks = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _saveButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _smallButton(
          icon: Icons.close_rounded,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        _smallButton(
          icon: Icons.cake_outlined,
          onTap: _openBirthdayQuickAdd,
        ),
      ],
    );
  }

  Widget _birthdayShortcut() {
    return GestureDetector(
      onTap: _openBirthdayQuickAdd,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          18,
          16,
          18,
          16,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF241D18),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.cake_outlined,
              color: Color(0xFFFFF9F1),
              size: 25,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Add Birthdays',
                    style: TextStyle(
                      color: Color(0xFFFFF9F1),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -.2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Add birthdays one by one without leaving the screen.',
                    style: TextStyle(
                      color: Color(0xFFCDBEAE),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFFFF9F1),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.3,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
        labelStyle: const TextStyle(
          color: Color(0xFF8B7D72),
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFFB1A59B),
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        filled: true,
        fillColor: const Color(0xFFFFFCF7),
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
            color: Color(0xFF241D18),
            width: .9,
          ),
        ),
      ),
    );
  }

  Widget _dropdownTile({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFFFFFCF7),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF241D18),
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return options.map((option) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF8B7D72),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    option,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }

  Widget _chipWrap({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = option == selected;

        return GestureDetector(
          onTap: () {
            onSelected(option);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF241D18)
                  : const Color(0xFFFFFCF7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF241D18)
                    : const Color(0xFFE2D8CD),
                width: .7,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFFFF9F1)
                    : const Color(0xFF6F6258),
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeThumbColor: const Color(0xFF241D18),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF241D18),
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF8B7D72),
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _dateTimeButton({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          14,
          13,
          14,
          13,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF8B7D72),
                fontSize: 9,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 6),
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
    );
  }

  Widget _smallButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF241D18),
          size: 25,
        ),
      ),
    );
  }

  Widget _saveButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _secondaryButton(
                label: 'Save + Add Another',
                onTap: () {
                  _saveEntry(addAnother: true);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _primaryButton(
                label: 'Save Entry',
                onTap: () {
                  _saveEntry(addAnother: false);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _textButton(
          label: 'Cancel',
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF241D18),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFFFF9F1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _secondaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF241D18),
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _textButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8B7D72),
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _labelText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${_shortMonth(date.month)} ${date.day}, ${date.year}';
  }

  String _shortMonth(int month) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return names[month - 1];
  }
}
