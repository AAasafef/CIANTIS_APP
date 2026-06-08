import 'package:flutter/material.dart';

class SelfCareScreen extends StatefulWidget {
  const SelfCareScreen({super.key});

  @override
  State<SelfCareScreen> createState() => _SelfCareScreenState();
}

class _SelfCareScreenState extends State<SelfCareScreen> {
  String mood = 'Okay';
  bool showBeautyConnection = true;
  bool showReflection = true;
  bool minimalMode = false;

  int selectedBackground = 0;
  int selectedCardStyle = 0;

  final List<Color> backgrounds = const [
    Color(0xFFF4EFE8),
    Color(0xFFF7F2ED),
    Color(0xFFEDE5DC),
    Color(0xFFF2EEE9),
  ];

  final List<Color> cards = const [
    Color(0xFFFFFBF6),
    Color(0xFFFCF7F0),
    Color(0xFFF7EFE7),
  ];

  final Color ink = const Color(0xFF2E2925);
  final Color softInk = const Color(0xFF7B716A);
  final Color deepTaupe = const Color(0xFF8B7768);
  final Color gold = const Color(0xFFC4A46A);

  final Map<String, bool> careTasks = {
    'Drank water': false,
    'Ate something nourishing': false,
    'Showered': false,
    'Brushed teeth': false,
    'Washed face': false,
    'Moisturized': false,
    'Clean clothes': false,
    'Took vitamins / meds': false,
    'Rested my body': false,
    'Prayed / quiet time': false,
  };

  final Map<String, bool> beautyBridges = {
    'Skin care touched': false,
    'Hair care touched': false,
    'Nails / hands checked': false,
    'Feminine care done': false,
    'Glow-up note saved': false,
  };

  final Set<String> dailyCheckIns = {
    'Shower or bathe',
    'Wash face morning',
    'Wash face night',
    'Brush teeth morning',
    'Brush teeth night',
    'Apply deodorant',
    'Change underwear',
    'Wear clean clothing',
    'Drink water',
    'Prayer / meditation',
    'Satin bonnet or scarf',
    'Moisturize skin',
    'Check scalp dryness',
    'Lip care',
  };

  final Set<String> weeklyCheckIns = {
    'Wash day',
    'Deep condition hair',
    'Scalp treatment',
    'Clean brushes and combs',
    'Face exfoliation',
    'Body exfoliation',
    'Foot scrub',
    'Trim or file nails',
    'Cuticle oil',
    'Eyebrow cleanup',
    'Clean makeup brushes',
    'Wash bedding',
    'Wash towels',
    'Sanitize phone',
    'Wash bonnets and scarves',
  };

  final Set<String> monthlyCheckIns = {
    'Breast self-exam',
    'Review cycle tracking',
    'Check feminine products inventory',
    'Replace old makeup',
    'Clean beauty drawers',
    'Hair growth photo',
    'Length check',
    'Density check',
    'Edge assessment',
    'Tension assessment',
    'Professional facial',
    'Brow shaping',
    'Full manicure',
    'Full pedicure',
  };

  final Set<String> yearlyCheckIns = {
    'Physical exam',
    'Blood work',
    'Gynecological exam',
    'Pap smear if due',
    'Dental exam',
    'Skin screening',
    'STI screening if needed',
    'Review wardrobe',
    'Replace worn bras',
    'Replace worn underwear',
    'Goal review',
    'Mental health check-in',
    'Financial self-care review',
  };

  final Map<String, bool> routineProgress = {};

  int get completedCare {
    int total = careTasks.values.where((done) => done).length;

    if (showBeautyConnection) {
      total += beautyBridges.values.where((done) => done).length;
    }

    total += routineProgress.entries
        .where((entry) => entry.value == true)
        .length;

    return total;
  }

  int get totalCare {
    int total = careTasks.length;

    if (showBeautyConnection) {
      total += beautyBridges.length;
    }

    total += dailyCheckIns.length +
        weeklyCheckIns.length +
        monthlyCheckIns.length +
        yearlyCheckIns.length;

    return total;
  }

  int get score {
    if (totalCare == 0) return 0;
    return ((completedCare / totalCare) * 100).round();
  }

  Color get bg => backgrounds[selectedBackground];
  Color get card => cards[selectedCardStyle];

  @override
  void initState() {
    super.initState();

    for (final item in [
      ...dailyCheckIns,
      ...weeklyCheckIns,
      ...monthlyCheckIns,
      ...yearlyCheckIns,
    ]) {
      routineProgress[item] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
          children: [
            _topBar(context),
            const SizedBox(height: 18),
            _scoreCard(),
            const SizedBox(height: 16),
            _moodCard(),
            const SizedBox(height: 16),
            _taskSection(
              title: 'Basic Self Care',
              subtitle: 'Small things that keep you together.',
              tasks: careTasks,
            ),
            if (showBeautyConnection) ...[
              const SizedBox(height: 16),
              _beautyBridgeSection(),
            ],
            const SizedBox(height: 16),
            _routinePreviewSection(
              title: 'Daily Check-In',
              subtitle: 'Your selected daily maintenance.',
              items: dailyCheckIns,
            ),
            if (!minimalMode) ...[
              const SizedBox(height: 16),
              _routinePreviewSection(
                title: 'Weekly Check-In',
                subtitle: 'Soft weekly upkeep.',
                items: weeklyCheckIns,
              ),
              const SizedBox(height: 16),
              _routinePreviewSection(
                title: 'Monthly Check-In',
                subtitle: 'Beauty, health, and maintenance review.',
                items: monthlyCheckIns,
              ),
              const SizedBox(height: 16),
              _routinePreviewSection(
                title: 'Yearly Check-In',
                subtitle: 'Big-picture health and life upkeep.',
                items: yearlyCheckIns,
              ),
            ],
            if (!minimalMode && showReflection) ...[
              const SizedBox(height: 16),
              _reflectionCard(),
            ],
            if (!minimalMode) ...[
              const SizedBox(height: 16),
              _emergencyCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: ink,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Self Care',
            style: TextStyle(
              color: ink,
              fontSize: 24,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.1,
            ),
          ),
        ),
        GestureDetector(
          onTap: _openSettingsSheet,
          child: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: card,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE1D7CE)),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: deepTaupe,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _scoreCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$score%',
            style: TextStyle(
              color: ink,
              fontSize: 42,
              fontWeight: FontWeight.w200,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Taking Care of You Today',
            style: TextStyle(
              color: softInk,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 7,
              backgroundColor: const Color(0xFFE7DED5),
              valueColor: AlwaysStoppedAnimation<Color>(deepTaupe),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moodCard() {
    final moods = ['Great', 'Good', 'Okay', 'Struggling', 'Overwhelmed'];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Daily Check In', 'How are you really feeling?'),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: moods.map((item) {
              final selected = mood == item;

              return GestureDetector(
                onTap: () => setState(() => mood = item),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? deepTaupe : const Color(0xFFF4EEE7),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected ? deepTaupe : const Color(0xFFE1D7CE),
                    ),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: selected ? Colors.white : softInk,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _taskSection({
    required String title,
    required String subtitle,
    required Map<String, bool> tasks,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title, subtitle),
          const SizedBox(height: 10),
          ...tasks.keys.map((task) {
            return _checkTile(
              label: task,
              value: tasks[task]!,
              onChanged: (value) {
                setState(() => tasks[task] = value ?? false);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _beautyBridgeSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxDecoration(
        borderColor: const Color(0xFFD8C29A),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            'Beauty Space Connection',
            'Self care items that can sync with Beauty Space later.',
          ),
          const SizedBox(height: 10),
          ...beautyBridges.keys.map((task) {
            return _checkTile(
              label: task,
              value: beautyBridges[task]!,
              onChanged: (value) {
                setState(() => beautyBridges[task] = value ?? false);
              },
            );
          }),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              // Later route:
              // Navigator.pushNamed(context, '/beauty-space');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8D7),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome_outlined,
                    color: gold,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Open Beauty Space later',
                      style: TextStyle(
                        color: deepTaupe,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: deepTaupe,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _routinePreviewSection({
    required String title,
    required String subtitle,
    required Set<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title, subtitle),
          const SizedBox(height: 10),
          ...items.map((item) {
            return _checkTile(
              label: item,
              value: routineProgress[item] ?? false,
              onChanged: (value) {
                setState(() => routineProgress[item] = value ?? false);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _reflectionCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('End of Day Reflection', 'Short and simple.'),
          const SizedBox(height: 14),
          _miniTextBox('Today I am proud of...'),
          const SizedBox(height: 10),
          _miniTextBox('Tomorrow I want to...'),
          const SizedBox(height: 10),
          _miniTextBox('Something good that happened...'),
        ],
      ),
    );
  }

  Widget _emergencyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEEE4DB),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD8CCC1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Self Care',
            style: TextStyle(
              color: ink,
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'When everything feels like too much.',
            style: TextStyle(
              color: softInk,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Drink water',
              'Take a shower',
              'Eat',
              'Pray',
              'Breathe',
              'Go outside',
              'Call someone',
              'Rest',
            ].map((item) => _smallPill(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _checkTile({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeColor: deepTaupe,
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        label,
        style: TextStyle(
          color: ink,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ink,
            fontSize: 17,
            fontWeight: FontWeight.w300,
            letterSpacing: .3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: softInk,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _miniTextBox(String hint) {
    return TextField(
      maxLines: 2,
      style: TextStyle(
        color: ink,
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: softInk.withOpacity(0.7),
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F2EC),
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _smallPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0D5CB)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: softInk,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration({Color? borderColor}) {
    return BoxDecoration(
      color: card,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: borderColor ?? const Color(0xFFE7DDD3),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  void _openSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: bg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.88,
              minChildSize: 0.50,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1C4BA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Self Care Settings',
                      style: TextStyle(
                        color: ink,
                        fontSize: 21,
                        fontWeight: FontWeight.w300,
                        letterSpacing: .5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Choose what belongs in your daily, weekly, monthly, and yearly check-ins.',
                      style: TextStyle(
                        color: softInk,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _settingsSwitch(
                      title: 'Minimal Mode',
                      subtitle: 'Hides longer sections from the main page.',
                      value: minimalMode,
                      onChanged: (value) {
                        setState(() => minimalMode = value);
                        modalSetState(() {});
                      },
                    ),
                    _settingsSwitch(
                      title: 'Beauty Space Connection',
                      subtitle: 'Shows soft beauty-related self-care items.',
                      value: showBeautyConnection,
                      onChanged: (value) {
                        setState(() => showBeautyConnection = value);
                        modalSetState(() {});
                      },
                    ),
                    _settingsSwitch(
                      title: 'End of Day Reflection',
                      subtitle: 'Shows simple reflection boxes.',
                      value: showReflection,
                      onChanged: (value) {
                        setState(() => showReflection = value);
                        modalSetState(() {});
                      },
                    ),
                    const SizedBox(height: 18),
                    _settingsLabel('Background'),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(backgrounds.length, (index) {
                        return _colorDot(
                          color: backgrounds[index],
                          selected: selectedBackground == index,
                          onTap: () {
                            setState(() => selectedBackground = index);
                            modalSetState(() {});
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 18),
                    _settingsLabel('Card Style'),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(cards.length, (index) {
                        return _colorDot(
                          color: cards[index],
                          selected: selectedCardStyle == index,
                          onTap: () {
                            setState(() => selectedCardStyle = index);
                            modalSetState(() {});
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    _settingsRoutineGroup(
                      title: 'Daily Options',
                      subtitle: 'Choose what shows in your daily check-in.',
                      activeItems: dailyCheckIns,
                      allOptions: _dailyOptions,
                      modalSetState: modalSetState,
                    ),
                    _settingsRoutineGroup(
                      title: 'Weekly Options',
                      subtitle: 'Choose what shows in your weekly check-in.',
                      activeItems: weeklyCheckIns,
                      allOptions: _weeklyOptions,
                      modalSetState: modalSetState,
                    ),
                    _settingsRoutineGroup(
                      title: 'Monthly Options',
                      subtitle: 'Choose what shows in your monthly check-in.',
                      activeItems: monthlyCheckIns,
                      allOptions: _monthlyOptions,
                      modalSetState: modalSetState,
                    ),
                    _settingsRoutineGroup(
                      title: 'Yearly Options',
                      subtitle: 'Choose what shows in your yearly check-in.',
                      activeItems: yearlyCheckIns,
                      allOptions: _yearlyOptions,
                      modalSetState: modalSetState,
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _settingsSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE3D8CE)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: softInk,
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: deepTaupe,
          ),
        ],
      ),
    );
  }

  Widget _settingsRoutineGroup({
    required String title,
    required String subtitle,
    required Set<String> activeItems,
    required List<String> allOptions,
    required StateSetter modalSetState,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE3D8CE)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
        iconColor: deepTaupe,
        collapsedIconColor: deepTaupe,
        title: Text(
          title,
          style: TextStyle(
            color: ink,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: softInk,
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
        ),
        children: allOptions.map((item) {
          final selected = activeItems.contains(item);

          return CheckboxListTile(
            value: selected,
            dense: true,
            activeColor: deepTaupe,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(
              item,
              style: TextStyle(
                color: ink,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  activeItems.add(item);
                  routineProgress.putIfAbsent(item, () => false);
                } else {
                  activeItems.remove(item);
                  routineProgress.remove(item);
                }
              });

              modalSetState(() {});
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _settingsLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: ink,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _colorDot({
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? deepTaupe : const Color(0xFFD8CCC1),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: selected
            ? Icon(
                Icons.check_rounded,
                color: deepTaupe,
                size: 18,
              )
            : null,
      ),
    );
  }

  final List<String> _dailyOptions = const [
    'Shower or bathe',
    'Wash face morning',
    'Wash face night',
    'Brush teeth morning',
    'Brush teeth night',
    'Floss',
    'Tongue scrape',
    'Use mouthwash',
    'Apply deodorant',
    'Clean under breasts',
    'Clean navel',
    'Clean behind ears',
    'Clean neck folds',
    'Clean feet thoroughly',
    'Dry between toes',
    'Change underwear',
    'Change socks',
    'Fresh pajamas / nightwear',
    'Cleanser',
    'Toner',
    'Serum',
    'Moisturizer',
    'Lip balm',
    'Eye cream',
    'Sunscreen',
    'Hand cream',
    'Body lotion',
    'Neck cream',
    'Chest moisturizer',
    'Brush hair',
    'Protect hair before bed',
    'Satin bonnet or scarf',
    'Satin pillowcase',
    'Oil scalp if needed',
    'Protect edges before bed',
    'Edge maintenance',
    'Moisturize natural hair if needed',
    'Check scalp dryness',
    'Oil ends if dry',
    'Protect extensions from tangling',
    'Check braids / locs / twists for buildup',
    'Monitor menstrual cycle',
    'Change pads / tampons / cup as needed',
    'Wear breathable underwear',
    'Monitor unusual symptoms',
    'Drink water',
    'Take vitamins',
    'Take medication',
    'Stretch',
    'Move body',
    'Get sunlight',
    'Monitor sleep quality',
    'Practice stress management',
    'Prayer / meditation',
    'Journal',
    'Gratitude practice',
    'Read something uplifting',
    'Quiet time',
    'Clean eyeglasses',
    'Apply fragrance',
    'Maintain posture',
    'Wear clean clothing',
    'Check lint / pet hair',
    'Clean shoes',
    'Jewelry check',
    'Outfit check',
    'Nail check',
    'Foot care',
    'Lip care',
    'Pelvic floor exercises',
  ];

  final List<String> _weeklyOptions = const [
    'Co-wash if needed',
    'Refresh curls',
    'Deep moisturize hair',
    'Style maintenance',
    'Shave underarms if desired',
    'Shave legs if desired',
    'Exfoliate rough areas',
    'Shampoo',
    'Condition',
    'Deep condition hair',
    'Scalp massage',
    'Scalp treatment',
    'Steam treatment',
    'Protein treatment if needed',
    'Finger detangle',
    'Trim single-strand knots inspection',
    'Clarify hair if needed',
    'Clean brushes and combs',
    'Clean scalp between tracks',
    'Tighten loose beads',
    'Check extension bonds',
    'Remove shedding hair',
    'Refresh extensions',
    'Wash wig',
    'Condition wig',
    'Clean wig cap',
    'Sanitize wig tools',
    'Check wig elastic bands',
    'Wash wig brushes',
    'Retwist inspection',
    'Scalp hydration',
    'Remove lint from locs',
    'Wash locs',
    'Palm rolling',
    'Face exfoliation',
    'Hydrating mask',
    'Clay mask',
    'Body exfoliation',
    'Foot scrub',
    'Lip scrub',
    'Trim nails',
    'File nails',
    'Buff nails',
    'Cuticle oil',
    'Clean under nails',
    'Check hangnails',
    'Foot soak',
    'Remove dead skin',
    'Moisturize heels',
    'Inspect feet',
    'Eyebrow cleanup',
    'Lash maintenance',
    'Clean makeup brushes',
    'Sanitize beauty tools',
    'Wash bedding',
    'Wash towels',
    'Clean makeup bag',
    'Sanitize phone',
    'Wash bonnets',
    'Wash scarves',
    'Clean flat irons',
    'Clean curling irons',
    'Clean hot combs',
    'Clean jewelry',
    'Clean purse',
    'Clean wallet',
    'Clean car interior',
    'Fresh sheets',
    'Fresh pillowcases',
  ];

  final List<String> _monthlyOptions = const [
    'Professional facial',
    'Chemical exfoliation',
    'Review skincare products',
    'Trim hair if needed',
    'Protein treatment',
    'Clarifying treatment',
    'Extension maintenance',
    'Silk press maintenance',
    'Wig deep clean',
    'Deep scalp detox',
    'Hair growth photo',
    'Length check',
    'Density check',
    'Edge assessment',
    'Tension assessment',
    'Breakage assessment',
    'Protective style evaluation',
    'Waxing appointment',
    'Threading appointment',
    'Brow shaping',
    'Facial maintenance',
    'Body scrub',
    'Full manicure',
    'Full pedicure',
    'Breast self-exam',
    'Review cycle tracking',
    'Check feminine products inventory',
    'Replace old makeup',
    'Clean beauty drawers',
    'Organize products',
    'Replace razors',
    'Check expiration dates',
    'Deep clean makeup collection',
    'Discard expired products',
    'Review medications',
    'Review supplements',
    'Weight and measurements check',
    'Financial self-care review',
    'Goal review',
  ];

  final List<String> _yearlyOptions = const [
    'Physical exam',
    'Blood work',
    'Gynecological exam',
    'Pap smear if due',
    'Mammogram if due',
    'Skin cancer screening',
    'STI screening if needed',
    'Dental exam',
    'Professional teeth cleaning',
    'Eye exam if needed',
    'Replace contacts if needed',
    'Major hair assessment',
    'Extension inventory',
    'Review wardrobe',
    'Replace worn bras',
    'Replace worn underwear',
    'Replace old shoes',
    'Update makeup shades',
    'Goal review',
    'Habit review',
    'Mental health check-in',
    'Financial self-care review',
    'Seasonal wardrobe refresh',
    'Hair consultation',
    'Fitness routine review',
    'Vision board update',
  ];
}