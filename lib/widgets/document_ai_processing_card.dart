import 'package:flutter/material.dart';

class DocumentAiProcessingCard
    extends StatefulWidget {
  const DocumentAiProcessingCard({
    super.key,
  });

  @override
  State<DocumentAiProcessingCard>
      createState() =>
          _DocumentAiProcessingCardState();
}

class _DocumentAiProcessingCardState
    extends State<
        DocumentAiProcessingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: Column(
        children: [
          RotationTransition(
            turns: controller,
            child: Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(
                  0xFFF4EFE8,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Color(
                  0xFFB08D6D,
                ),
                size: 32,
              ),
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          const Text(
            'AI Processing Active',
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.w500,
              color: Color(
                0xFF2D241D,
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            'Scanning keywords, detecting document types, extracting data, and organizing your vault.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black.withOpacity(
                .55,
              ),
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              99,
            ),
            child: const LinearProgressIndicator(
              value: .72,
              minHeight: 10,
              backgroundColor:
                  Color(
                0xFFF4EFE8,
              ),
              valueColor:
                  AlwaysStoppedAnimation(
                Color(
                  0xFFB08D6D,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}