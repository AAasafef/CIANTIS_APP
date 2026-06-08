import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxuryAvatar extends StatelessWidget {
  final double radius;

  final String? imagePath;

  const LuxuryAvatar({
    super.key,
    this.radius = 34,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,

      backgroundColor:
          CiantisTheme.profileBrown,

      backgroundImage:
          imagePath != null &&
                  imagePath!.isNotEmpty
              ? AssetImage(imagePath!)
              : null,

      child:
          imagePath == null ||
                  imagePath!.isEmpty
              ? Icon(
                  Icons.person,
                  color:
                      CiantisTheme.white,
                  size: radius,
                )
              : null,
    );
  }
}
