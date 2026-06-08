import 'package:flutter/material.dart';

class DailyCheckInScreen extends StatefulWidget {
  const DailyCheckInScreen({
    super.key,
  });

  @override
  State<DailyCheckInScreen> createState() =>
      _DailyCheckInScreenState();
}

class _DailyCheckInScreenState
    extends State<DailyCheckInScreen> {
  String selectedMood = 'Peaceful';
  double energy = 5;

  final TextEditingController feelingsController =
      TextEditingController();

  final TextEditingController gratitudeController =
      TextEditingController();

  final List<String> moods = const [
    'Peaceful',
    'Grateful',
    'Heavy',
    'Focused',
    'Tired',
    'Anxious',
  ];

  @override
  void dispose() {
    feelingsController.dispose();
    gratitudeController.dispose();
    super.dispose();
  }

  void _completeCheckIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const CheckInCompleteScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(19),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Daily Check-In',
                    style: TextStyle(
                      color: Color(0xFF2D241D),
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                'How are you feeling right now?',
                style: TextStyle(
                  color: Color(0xFF2D241D),
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: moods.map((mood) {
                  final isSelected =
                      selectedMood == mood;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = mood;
                      });
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2D241D)
                            : Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        mood,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF6E5846),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 26),

              _SectionCard(
                title: 'Energy Level',
                child: Column(
                  children: [
                    Slider(
                      value: energy,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      activeColor:
                          const Color(0xFF2D241D),
                      inactiveColor:
                          const Color(0xFFE3D8CE),
                      label:
                          energy.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          energy = value;
                        });
                      },
                    ),
                    Text(
                      '${energy.round()} / 10',
                      style: const TextStyle(
                        color: Color(0xFF6E5846),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _SectionCard(
                title: 'What are you feeling?',
                child: TextField(
                  controller: feelingsController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText:
                        'Write what is on your heart...',
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _SectionCard(
                title: 'One thing you are grateful for',
                child: TextField(
                  controller: gratitudeController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText:
                        'Today, I am grateful for...',
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 26),

              GestureDetector(
                onTap: _completeCheckIn,
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D241D),
                    borderRadius:
                        BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Complete Check-In',
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF2D241D),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class CheckInCompleteScreen extends StatelessWidget {
  const CheckInCompleteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(34),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 76,
                    width: 76,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D241D),
                      borderRadius:
                          BorderRadius.circular(28),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Check-In Complete',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2D241D),
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your reflection has been added to today’s devotional rhythm.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          Colors.black.withOpacity(.55),
                      fontSize: 15,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 26),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF2D241D),
                        borderRadius:
                            BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Return Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}