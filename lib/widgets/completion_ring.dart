import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class CompletionRing extends StatelessWidget {
  final double progress;

  const CompletionRing({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 90,

      child: Stack(
        alignment: Alignment.center,
        children: [

          SizedBox(
            height: 90,
            width: 90,

            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,

              backgroundColor:
                  Colors.white.withOpacity(
                .08,
              ),

              valueColor:
                  const AlwaysStoppedAnimation(
                CiantisTheme.white,
              ),
            ),
          ),

          Text(
            '${(progress * 100).toInt()}%',

            style: const TextStyle(
              color: CiantisTheme.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
