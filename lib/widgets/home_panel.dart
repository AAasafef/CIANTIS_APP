import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';
import 'glass_container.dart';

class HomePanel extends StatelessWidget {
  const HomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: GlassContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                color: CiantisTheme.whiteSoft,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your luxury life OS',
              style: TextStyle(
                color: CiantisTheme.white,
                fontSize: CiantisTheme.titleSize,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Everything organized beautifully.',
              style: TextStyle(
                color: CiantisTheme.whiteSoft,
                fontSize: CiantisTheme.bodySize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
