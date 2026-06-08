import 'package:flutter/material.dart';

class CycleNotesScreen extends StatefulWidget {
  const CycleNotesScreen({super.key});

  @override
  State<CycleNotesScreen> createState() =>
      _CycleNotesScreenState();
}

class _CycleNotesScreenState
    extends State<CycleNotesScreen> {
  final TextEditingController notesController =
      TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            24,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _BackButtonBox(
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 42,
                            height: .95,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1.4,
                            color: Color(0xFF241D18),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'PERIOD JOURNAL',
                          style: TextStyle(
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
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFFBF8F4,
                    ).withOpacity(.9),
                    borderRadius:
                        BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(
                        0xFFE2D8CD,
                      ),
                      width: .7,
                    ),
                  ),
                  child: TextField(
                    controller: notesController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'How are you feeling today?',
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF241D18),
                      height: 1.5,
                      fontWeight: FontWeight.w300,
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
          color: const Color(
            0xFFFBF8F4,
          ).withOpacity(.9),
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: const Icon(
          Icons.chevron_left_rounded,
          color: Color(0xFF241D18),
        ),
      ),
    );
  }
}