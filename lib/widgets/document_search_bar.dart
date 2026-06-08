import 'package:flutter/material.dart';

class DocumentSearchBar
    extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const DocumentSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),

      child: TextField(
        onChanged: onChanged,

        decoration: InputDecoration(
          border:
              InputBorder.none,

          hintText:
              'Search documents...',

          hintStyle: TextStyle(
            color:
                Colors.black
                    .withOpacity(.45),
          ),

          prefixIcon: Icon(
            Icons.search,
            color:
                Colors.black
                    .withOpacity(.45),
          ),

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }
}