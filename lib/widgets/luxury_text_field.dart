import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxuryTextField extends StatelessWidget {
  final String hintText;

  final IconData? icon;

  final TextEditingController? controller;

  const LuxuryTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      style: const TextStyle(
        color: CiantisTheme.white,
      ),

      decoration: InputDecoration(
        filled: true,

        fillColor:
            Colors.white.withOpacity(
          .10,
        ),

        hintText: hintText,

        hintStyle: const TextStyle(
          color:
              CiantisTheme.whiteSoft,
        ),

        prefixIcon: icon != null
            ? Icon(
                icon,
                color: CiantisTheme
                    .whiteSoft,
              )
            : null,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
