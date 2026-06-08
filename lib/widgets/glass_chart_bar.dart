import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class GlassChartBar extends StatelessWidget {
  final double value;

  final String label;

  const GlassChartBar({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.end,
      children: [

        Container(
          height: value,
          width: 22,

          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(
              .22,
            ),

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            border: Border.all(
              color:
                  CiantisTheme.white,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          label,
          style: const TextStyle(
            color:
                CiantisTheme.whiteSoft,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
