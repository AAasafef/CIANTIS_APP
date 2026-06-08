import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,

      style: const TextStyle(
        color: CiantisTheme.white,
      ),

      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: const TextStyle(
          color: CiantisTheme.whiteSoft,
        ),

        prefixIcon: const Icon(
          Icons.search,
          color: CiantisTheme.whiteSoft,
        ),

        filled: true,

        fillColor:
            Colors.white.withOpacity(.08),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
