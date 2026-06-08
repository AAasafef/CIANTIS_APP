import 'package:flutter/material.dart';

class CycleDayEditorScreen extends StatefulWidget {
  final DateTime selectedDate;

  const CycleDayEditorScreen({
    super.key,
    required this.selectedDate,
  });

  @override
  State<CycleDayEditorScreen> createState() =>
      _CycleDayEditorScreenState();
}

class _CycleDayEditorScreenState extends State<CycleDayEditorScreen> {
  final TextEditingController notesController =
      TextEditingController();

  final TextEditingController customController =
      TextEditingController();

  String selectedFlow = 'Medium';
  String selectedMood = 'Sensitive';
  String selectedDischarge = 'Clear';

  final List<String> flowLogs = [
    '9:10 AM — Medium flow',
    '1:42 PM — Light flow',
  ];

  final Set<String> symptoms = {
    'Cramps',
    'Back Pain',
  };

  final List<String> customLogs = [
    'Random headache',
  ];

  final List<String> symptomOptions = [
    'Cramps',
    'Back Pain',
    'Abd. Pain',
    'Headache',
    'Bloating',
    'Fatigue',
    'Mood Swings',
    'Acne',
    'Nausea',
  ];

  @override
  void initState() {
    super.initState();
    notesController.text =
        'Cramps worse than usual. Lower back pain and feeling emotional.';

    notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    notesController.dispose();
    customController.dispose();
    super.dispose();
  }

  void _toggleSymptom(String value) {
    setState(() {
      if (symptoms.contains(value)) {
        symptoms.remove(value);
      } else {
        symptoms.add(value);
      }
    });
  }

  void _addFlowLog(String value) {
    setState(() {
      selectedFlow = value;
      flowLogs.insert(
        0,
        '${_timeNow()} — $value flow',
      );
    });
  }

  void _addCustomLog() {
    final text = customController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      customLogs.insert(0, text);
      customController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                title: 'Edit Day',
                subtitle:
                    '${_monthName(widget.selectedDate.month).toUpperCase()} ${widget.selectedDate.day}, ${widget.selectedDate.year}',
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),

              _SectionCard(
                title: 'FLOW',
                child: Column(
                  children: [
                    _SegmentSelector(
                      options: const [
                        'Spotting',
                        'Light',
                        'Medium',
                        'Heavy',
                      ],
                      selected: selectedFlow,
                      onChanged: _addFlowLog,
                    ),
                    const SizedBox(height: 14),
                    ...flowLogs.map(
                      (log) => _SavedLine(text: log),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                title: 'SYMPTOMS',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...symptomOptions.map((item) {
                      final active = symptoms.contains(item);

                      return _ChipButton(
                        label: item,
                        active: active,
                        onTap: () => _toggleSymptom(item),
                      );
                    }),
                    _ChipButton(
                      label: '+ Custom',
                      active: false,
                      onTap: () {
                        _showCustomSymptomSheet(context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                title: 'DISCHARGE',
                child: _SegmentSelector(
                  options: const [
                    'None',
                    'Clear',
                    'White',
                    'Sticky',
                    'Watery',
                  ],
                  selected: selectedDischarge,
                  onChanged: (value) {
                    setState(() {
                      selectedDischarge = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                title: 'MOOD',
                child: _SegmentSelector(
                  options: const [
                    'Calm',
                    'Sensitive',
                    'Irritable',
                    'Sad',
                    'Anxious',
                  ],
                  selected: selectedMood,
                  onChanged: (value) {
                    setState(() {
                      selectedMood = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                title: 'CUSTOM LOG',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: customController,
                            decoration: const InputDecoration(
                              hintText:
                                  'Add discharge, headache, craving, anything...',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF241D18),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _addCustomLog,
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF241D18),
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Color(0xFFFFF9F1),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (customLogs.isNotEmpty)
                      const SizedBox(height: 12),
                    ...customLogs.map(
                      (log) => _SavedLine(text: log),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                title: 'NOTES',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4EFE8),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE2D8CD),
                          width: .7,
                        ),
                      ),
                      child: TextField(
                        controller: notesController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type anything...',
                        ),
                        style: const TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 14,
                          height: 1.45,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'SAVED NOTES',
                      style: TextStyle(
                        color: Color(0xFF8B7D72),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notesController.text.isEmpty
                          ? 'Nothing written yet.'
                          : notesController.text,
                      style: const TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 13,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
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

  void _showCustomSymptomSheet(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF4EFE8),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Custom symptom',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final text = controller.text.trim();

                    if (text.isNotEmpty) {
                      setState(() {
                        symptoms.add(text);
                        symptomOptions.add(text);
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF241D18),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFFFFF9F1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _Header({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BackButtonBox(onTap: onBack),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 42,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.4,
                  color: Color(0xFF241D18),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3,
                  color: Color(0xFF8B7D72),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackButtonBox extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButtonBox({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4).withOpacity(.9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: const Icon(
          Icons.chevron_left_rounded,
          color: Color(0xFF241D18),
          size: 24,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.9),
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
            title,
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.6,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SegmentSelector extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;

  const _SegmentSelector({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((item) {
        final active = selected == item;

        return _ChipButton(
          label: item,
          active: active,
          onTap: () => onChanged(item),
        );
      }).toList(),
    );
  }
}

class _ChipButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ChipButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF241D18)
              : const Color(0xFFF4EFE8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active
                ? const Color(0xFFFFF9F1)
                : const Color(0xFF6F6258),
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class _SavedLine extends StatelessWidget {
  final String text;

  const _SavedLine({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFE8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6F6258),
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

String _timeNow() {
  final now = TimeOfDay.now();
  final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = now.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:$minute $period';
}

String _monthName(int month) {
  const names = [
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

  return names[month - 1];
}
