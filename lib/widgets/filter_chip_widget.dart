import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class FilterChipWidget extends StatelessWidget {
  final String text;

  final bool selected;

  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withOpacity(.20)
              : Colors.white.withOpacity(.08),

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? CiantisTheme.white
                : Colors.white.withOpacity(.08),
          ),
        ),

        child: Text(
          text,
          style: const TextStyle(
            color: CiantisTheme.white,
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
