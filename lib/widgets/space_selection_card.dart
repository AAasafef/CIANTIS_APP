import 'package:flutter/material.dart';

import '../models/space_model.dart';

class SpaceSelectionCard extends StatelessWidget {
  final SpaceModel space;

  final VoidCallback onTap;

  const SpaceSelectionCard({
    super.key,
    required this.space,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = space.selected;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF2D241D)
              : const Color(0xFFF7F2EC),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: selected
                ? const Color(0xFFB08D6D)
                : Colors.black.withOpacity(.05),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    child: Image.asset(
                      space.imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: const Color(0xFFE7D8C8),
                          child: Icon(
                            space.icon,
                            color: const Color(0xFF8B735F),
                            size: 42,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.04),
                            Colors.black.withOpacity(.42),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? const Color(0xFFB08D6D)
                            : Colors.white.withOpacity(.88),
                      ),
                      child: Icon(
                        selected
                            ? Icons.check_rounded
                            : Icons.add_rounded,
                        size: 17,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 14,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.18),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        space.icon,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: selected
                          ? Colors.white
                          : const Color(0xFF2C221B),
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    space.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: selected
                          ? Colors.white.withOpacity(.70)
                          : Colors.black.withOpacity(.62),
                      height: 1.5,
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