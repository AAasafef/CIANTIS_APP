import 'package:flutter/material.dart';

class SpacePreviewOverlay
    extends StatelessWidget {

  final int updates;

  final int overdue;

  final double stress;

  const SpacePreviewOverlay({
    super.key,
    required this.updates,
    required this.overdue,
    required this.stress,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        _pill(
          icon:
              Icons.notifications_none,

          text:
              '$updates Updates',
        ),

        const SizedBox(
          width: 10,
        ),

        _pill(
          icon:
              Icons.schedule,

          text:
              '$overdue Overdue',
        ),

        const SizedBox(
          width: 10,
        ),

        _pill(
          icon:
              Icons.psychology_outlined,

          text:
              'Stress ${(stress * 100).toInt()}%',
        ),
      ],
    );
  }

  Widget _pill({
    required IconData icon,
    required String text,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color:
            Colors.white
                .withOpacity(
          .10,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color:
              Colors.white
                  .withOpacity(
            .08,
          ),
        ),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color:
                Colors.white
                    .withOpacity(
              .82,
            ),

            size: 14,
          ),

          const SizedBox(
            width: 6,
          ),

          Text(
            text,

            style: TextStyle(
              color:
                  Colors.white
                      .withOpacity(
                .82,
              ),

              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}