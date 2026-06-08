import 'package:flutter/material.dart';

class SpacesSearchBar
    extends StatelessWidget {
  const SpacesSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          hintText:
              'Search spaces...',
          hintStyle: TextStyle(
            color: Colors.black
                .withOpacity(.38),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black
                .withOpacity(.45),
          ),
        ),
      ),
    );
  }
}