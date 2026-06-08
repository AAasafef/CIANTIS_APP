import 'package:flutter/material.dart';

class SpaceQuickActionRow
    extends StatelessWidget {

  const SpaceQuickActionRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,

      child: ListView(
        scrollDirection:
            Axis.horizontal,

        children: [

          _pill(
            icon: Icons.add,
            text: 'Add Task',
          ),

          const SizedBox(width: 12),

          _pill(
            icon:
                Icons.note_add_outlined,
            text: 'New Note',
          ),

          const SizedBox(width: 12),

          _pill(
            icon:
                Icons.calendar_month_outlined,
            text: 'Schedule',
          ),

          const SizedBox(width: 12),

          _pill(
            icon:
                Icons.auto_awesome_outlined,
            text: 'Focus',
          ),
        ],
      ),
    );
  }

  Widget _pill({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          22,
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black
                    .withOpacity(
              .04,
            ),

            blurRadius: 18,

            offset:
                const Offset(
              0,
              10,
            ),
          ),
        ],
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color:
                const Color(
              0xFF6E5846,
            ),
            size: 18,
          ),

          const SizedBox(width: 10),

          Text(
            text,
            style: const TextStyle(
              color:
                  Color(
                0xFF2D241D,
              ),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}