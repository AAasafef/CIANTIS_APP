import 'package:flutter/material.dart';

class DocumentScanAnimationCard extends StatefulWidget {
  const DocumentScanAnimationCard({
    super.key,
  });

  @override
  State<DocumentScanAnimationCard> createState() =>
      _DocumentScanAnimationCardState();
}

class _DocumentScanAnimationCardState
    extends State<DocumentScanAnimationCard>
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
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 160,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF4EFE8,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
              ),

              Positioned(
                top:
                    40 +
                    (controller.value *
                        120),
                child: Container(
                  height: 4,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFB08D6D,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      999,
                    ),
                  ),
                ),
              ),

              const Positioned(
                bottom: 30,
                child: Text(
                  'Scanning Document',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(
                      0xFF2D241D,
                    ),
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}